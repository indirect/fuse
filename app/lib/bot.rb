# A user-like actor on GitHub that represents the app.
class Bot
  attr_reader :github, :name

  def initialize(github_client, name)
    @github = github_client
    @name = name
  end

  def comment(repo, issue, body)
    github.add_comment(repo, issue, body)
  end

  def append_comment(repo, comment, addendum)
    body = github.issue_comment(repo, comment)[:body]
    new_body = [body, "\n", addendum].join("\n")
    github.update_comment(repo, comment, new_body)
  end

  def queue_test(repo, issue, message)
    # TODO store this in the database and update it on push webhooks
    pr = github.pull_request(repo, issue)

    # Create a temporary branch to act as the base for the merge
    begin
      github.create_ref(repo, "heads/#{name}/test.tmp", pr.base.sha)
    rescue Octokit::UnprocessableEntity
      github.update_ref(repo, "heads/#{name}/test.tmp", pr.base.sha, true)
    end

    # Create a merge commit in the testing branch
    merge = github.post "#{Octokit::Repository.path repo}/merges", {
      base: "#{name}/test.tmp", head: pr.head.ref, commit_message: message
    }

    # Move the merge commit to be tested by Travis
    begin
      github.update_ref(repo, "heads/#{name}/test", merge[:sha], true)
    rescue Octokit::UnprocessableEntity
      github.create_ref(repo, "heads/#{name}/test", merge[:sha])
    end

    github.delete_ref(repo, "heads/#{name}/test.tmp")

    merge[:sha]
  end

  def status(repo, sha, state, description, url)
    github.create_status(repo, sha, state,
      target_url: url,
      description: description,
      context: "merge/fuse"
    )
  end

  def merge(repo, issue, sha)
    # TODO store this in the database and update it on push webhooks
    pr = github.pull_request(repo, issue)

    # Fast forward the base branch to the merge commit that tested green
    github.update_ref(repo, "heads/#{pr.base.ref}", sha)

    # Delete the bot testing branch
    github.delete_ref(repo, "heads/#{name}/test")

    # Delete the PR head if it's in the same repo as the base
    if pr.head.repo.full_name == pr.base.repo.full_name
      begin
        github.delete_branch(repo, pr.head.ref)
      rescue Octokit::UnprocessableEntity
        # cool, it must already be gone
      end
    end
  end
end
