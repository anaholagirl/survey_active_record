class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.column :name, :string
      t.column :question_id, :int

      t.timestamps
    end
  end
end
