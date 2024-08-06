module IssueHierarchyFilter
  module Patches
    module AgileQueryPatch
      extend ActiveSupport::Concern
      include CommonQueryPatchMethods
    end
  end
end

if Redmine::Plugin.installed?(:redmine_agile) &&
  Gem::Version.new(Redmine::Plugin.find(:redmine_agile).version) >= Gem::Version.new('1.4.3')
  AgileQuery.send(:include, IssueHierarchyFilter::Patches::AgileQueryPatch)
end
