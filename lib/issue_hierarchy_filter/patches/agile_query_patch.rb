if Redmine::Plugin.installed?(:redmine_agile) &&
  Gem::Version.new(Redmine::Plugin.find(:redmine_agile).version) >= Gem::Version.new('1.4.3')

module IssueHierarchyFilter
  module Patches
    module AgileQueryPatch
      extend ActiveSupport::Concern

      included do
        include InstanceMethods

        alias_method :initialize_available_filters_without_issue_hierarchy_filter, :initialize_available_filters
        alias_method :initialize_available_filters, :initialize_available_filters_with_issue_hierarchy_filter
      end

      module InstanceMethods
        def sql_for_issue_level_field(field, operator, value)
          subquery =
            "SELECT il.issue_id " +
            "FROM #{IssueLevel.table_name} il "

          case operator
          when "="
            int_values = value.first.to_s.scan(/[+-]?\d+/).map(&:to_i).join(",")
            subquery += "WHERE il.level IN (#{int_values})"
          when ">=", "<="
            subquery += "WHERE il.level #{operator} #{value[0].to_i}"
          when "><"
            subquery += "WHERE il.level >= #{value.map(&:to_i).min}"
            subquery += "AND il.level <= #{value.map(&:to_i).max}"
          when "!*"
            subquery += "WHERE il.level = 0"
          when "*"
            subquery += "WHERE il.level > 0"
          end

          "issues.id IN (#{subquery})"
        end

        def initialize_available_filters_with_issue_hierarchy_filter
          initialize_available_filters_without_issue_hierarchy_filter

          add_available_filter("issue_level", type: :integer)
        end
      end
    end
  end
end

AgileQuery.send(:include, IssueHierarchyFilter::Patches::AgileQueryPatch)

end
