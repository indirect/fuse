# A user-like actor on GitHub that represents the app.
class Bot
  attr_reader :github

  def initialize(github_client)
    @github = github_client
  end

  def name
    Github.app.name
  end

  def comment(repo, issue, body)
    github.add_comment(repo, issue, body)
  end

  def merge(repo, issue, message)
    pr = github.pull_request(repo, issue)

    # Create a merge commit in the base branch from the PR head
    github.post "#{Octokit::Repository.path repo}/merges", {
      base: pr.base.ref, head: pr.head.ref, commit_message: message
    }

    # Delete the PR head if it's in the same repo as the base
    if pr.head.repo.full_name == pr.base.repo.full_name
      github.delete_branch(repo, pr.head.ref)
    end
  end
end
