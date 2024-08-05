class CreateIssueLevels < ActiveRecord::Migration[6.1]
  def change
    create_table :issue_levels do |t|
      t.integer :issue_id
      t.integer :level
    end

    add_index :issue_levels, :issue_id
  end
end
