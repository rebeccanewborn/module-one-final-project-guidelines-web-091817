class AddCohortIdToPeople < ActiveRecord::Migration
  def change
    add_column :people, :cohort_id, :integer
  end
end
