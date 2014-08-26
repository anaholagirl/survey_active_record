require 'spec_helper'

describe Question do
  it 'belongs to survey' do
    test_survey = Survey.create({:name => 'Are you hungry?'})
    test_question = Question.create({:name => 'Did you eat breakfast?', :survey_id => test_survey.id })
    expect(test_question.survey).to eq test_survey
  end

  # it 'has many responses' do
  #   test_question = Question.create({:name => 'What is the best Mexican restaurant?'})
  #   test_response1 = Response.create({:name => 'Don Pedro', :question_id => test_question.id})
  #   test_response2 = Response.create({:name => 'Por Que No?', :question_id => test_question.id})
  #   expect(test_question.responses).to eq [test_response1, test_response2]
  # end
end
