require 'spec_helper'
require 'pry'

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

  # it 'has many responses through choices' do
  #   test_question = Question.create({:name => 'What is the coolest animal?'})
  #   test_choice1 = Choice.create({:name => 'Elephant'})
  #   test_choice2 = Choice.create({:name => 'Capybara'})
  #   test_response1 = Response.create({:question_id => test_question.id, :choice_id =>test_choice1})
  #   test_response2 = Response.create({:question_id => test_question.id, :choice_id => test_choice2})
  #   binding.pry
  #   expect(test_question.responses).to eq [test_response1, test_response2]
  # end
end
