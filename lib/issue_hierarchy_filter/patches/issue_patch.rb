module IssueHierarchyFilter
  module Patches
    module IssuePatch
      def self.included(base)

        base.class_eval do
          after_save :update_issue_level
          after_destroy :destroy_issue_level

          def calculate_level(level=0)
            if parent_issue_id.present?
              level = Issue.find(parent_issue_id).calculate_level(level+1)
            end
            level
          end

          private

          def update_issue_level
            level = calculate_level
            IssueLevel.find_or_create_by(issue_id: id).update(level: level)
          end

          def destroy_issue_level
            IssueLevel.find_by(issue_id: id)&.destroy
          end
        end
      end
    end
  end
end

Issue.send(:include, IssueHierarchyFilter::Patches::IssuePatch)
