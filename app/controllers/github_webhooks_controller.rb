class GithubWebhooksController < ActionController::Base
  include GithubWebhook::Processor

  def create
    event_name = request.headers['X-GitHub-Event']
    logger.tagged("GithubWebhook", event_name) do
      super
    end
  end

  def webhook_secret(payload)
    ENV['GITHUB_WEBHOOK_SECRET']
  end

  # GitHub's documented event list is at https://developer.github.com/v3/activity/events/types
  # This set of events is complete as of 2017-07-22.

  def github_commit_comment(payload)
  end

  def github_create(payload)
  end

  def github_delete(payload)
  end

  def github_deployment(payload)
  end

  def github_deployment_status(payload)
  end

  def github_download(payload)
  end

  def github_follow(payload)
  end

  def github_fork(payload)
  end

  def github_fork_apply(payload)
  end

  def github_gist(payload)
  end

  def github_gollum(payload)
  end

  def github_installation(payload)
    case payload[:action]
    when "created"
      install = Installation.from_github!(payload[:installation])
      Repository.import_from_github!(payload[:repositories], installation_id: install.id)
    when "deleted"
      gid = payload.fetch(:installation).fetch(:id)
      Installation.where(github_id: gid).destroy_all
    else
      raise RuntimeError, "Unknown installation action #{payload[:action]}!"
    end
  end

  def github_installation_repositories(payload)
  end

  def github_integration_installation(payload)
    # deprecated duplicate of `installation`, so we ignore it
  end

  def github_integration_installation_repositories(payload)
    # deprecated duplicate of `installation_repositories`, so we ignore it
  end

  def github_issues(payload)
  end

  def github_issue_comment(payload)
  end

  def github_label(payload)
  end

  def github_marketplace_purchase(payload)
  end

  def github_member(payload)
  end

  def github_membership(payload)
  end

  def github_milestone(payload)
  end

  def github_organization(payload)
  end

  def github_org_block(payload)
  end

  def github_page_build(payload)
  end

  def github_ping(payload)
  end

  def github_project(payload)
  end

  def github_project_card(payload)
  end

  def github_project_column(payload)
  end

  def github_public(payload)
  end

  def github_pull_request(payload)
  end

  def github_pull_request_review(payload)
  end

  def github_pull_request_review_comment(payload)
  end

  def github_push(payload)
  end

  def github_release(payload)
  end

  def github_repository(payload)
  end

  def github_status(payload)
  end

  def github_team(payload)
  end

  def github_team_add(payload)
  end

  def github_watch(payload)
  end

end