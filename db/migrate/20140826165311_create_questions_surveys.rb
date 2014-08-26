class CreateQuestionsSurveys < ActiveRecord::Migration
  def change
    create_table :questions_surveys do |t|
      t.column :survey_id, :int
      t.column :question_id, :int

      t.timestamps
    end
  end
end
