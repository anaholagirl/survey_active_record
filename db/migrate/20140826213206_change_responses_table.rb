class ChangeResponsesTable < ActiveRecord::Migration
  def change
    remove_column :responses, :name, :string
    add_column :responses, :choice_id, :integer
  end
end
