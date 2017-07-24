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

  def test(repo, issue)
    # TODO store this in the database and update it on push webhooks
    pr = github.pull_request(repo, issue)

    # Create a temporary branch to act as the base for the merge
    begin
      github.delete_ref(repo, "heads/#{name}/test.tmp", pr.base.sha)
    rescue Octokit::UnprocessableEntity
    end
    github.create_ref(repo, "heads/#{name}/test.tmp", pr.base.sha)

    # Create a merge commit in the testing branch
    github.post "#{Octokit::Repository.path repo}/merges", {
      base: pr.base.ref, head: pr.head.ref, commit_message: message
    }
  end

  def merge(repo, issue, message)
    # TODO store this in the database and update it on push webhooks
    pr = github.pull_request(repo, issue)

    # Fast forward the base branch to the merge commit that tested green
    github.update_ref(repo, pr.base.ref, )
    
    # TODO code

    # Delete the PR head if it's in the same repo as the base
    if pr.head.repo.full_name == pr.base.repo.full_name
      github.delete_branch(repo, pr.head.ref)
    end
  end
end
