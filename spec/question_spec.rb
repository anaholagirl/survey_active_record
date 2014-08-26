require 'spec_helper'

describe Question do
  it 'belongs to survey' do
    test_survey = Survey.create({:name => 'Are you hungry?'})
    test_question = Question.create({:name => 'Did you eat breakfast?', :survey_id => test_survey.id })
    expect(test_question.survey).to eq test_survey
  end

  it 'has many choices' do
    test_question = Question.create({:name => 'What is the best Mexican restaurant?'})
    test_choice1 = Choice.create({:name => 'Por que no?', :question_id => test_question.id})
     test_choice2 = Choice.create({:name => 'Don Pedro', :question_id => test_question.id})
    expect(test_question.choices).to eq [test_choice1, test_choice2]
  end
end
