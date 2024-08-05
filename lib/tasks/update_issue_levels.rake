require 'ruby-progressbar'

namespace :issue_hierarchy_filter do
  desc "Update issue levels"
  task update_levels: :environment do
    progressbar = ProgressBar.create(total: Issue.all.count, format: 'Progress: %c/%C |%B| %a %e')
    Issue.find_each do |issue|
      progressbar.increment
      level = issue.calculate_level
      IssueLevel.find_or_create_by(issue_id: issue.id).update(level: level)
    end
  end
end
