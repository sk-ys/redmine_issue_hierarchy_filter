module IssueHierarchyFilter
  module Patches
    module IssueQueryPatch
      extend ActiveSupport::Concern
      include CommonQueryPatchMethods
    end
  end
end

IssueQuery.send(:include, IssueHierarchyFilter::Patches::IssueQueryPatch)
