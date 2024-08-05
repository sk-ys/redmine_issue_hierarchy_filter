Dir[File.join(File.expand_path('../lib/issue_hierarchy_filter/patches', __FILE__), '*.rb')].each do |patch|
  require_dependency patch
end

Redmine::Plugin.register :redmine_issue_hierarchy_filter do
  name 'Redmine Issue Hierarchy Filter'
  author 'sk-ys'
  description 'Adds issue hierarchy filter'
  version '0.1.1'
  url 'https://github.com/sk-ys/redmine_issue_hierarchy_filter'
  author_url 'https://github.com/sk-ys'
end
