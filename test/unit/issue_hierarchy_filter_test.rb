require File.expand_path('../../test_helper', __FILE__)

class IssueHierarchyFilterTest < ActiveSupport::TestCase
  fixtures :issues, :projects, :versions, :trackers, :issue_categories

  def test_calculate_level
    issue1 = Issue.find(1)
    assert_equal 0, issue1.calculate_level

    issue2 = Issue.find(2)
    issue2.parent_issue_id = 1
    issue2.save
    assert_equal 1, issue2.calculate_level

    issue3 = Issue.find(3)
    issue3.parent_issue_id = 2
    issue3.save
    assert_equal 2, issue3.calculate_level
  end

  def test_update_issue_level
    issue = Issue.find(2)
    issue.parent_issue_id = nil
    issue.save

    issue_level = IssueLevel.find_by(issue_id: issue.id)
    assert_equal 0, issue_level.level

    issue.parent_issue_id = 1
    issue.save

    issue_level = IssueLevel.find_by(issue_id: issue.id)
    assert_equal 1, issue_level.level
  end

  def test_destroy_issue_level
    issue = Issue.find(1)
    issue.save

    issue_level = IssueLevel.find_by(issue_id: issue.id)
    assert_not_nil issue_level

    issue.destroy

    issue_level = IssueLevel.find_by(issue_id: issue.id)
    assert_nil issue_level
  end
end
