require 'spec_helper'

describe Survey do
  it 'has_many questions' do
    test_survey = Survey.create({:name => 'Are you hungry?'})
    test_question1 = Question.create({:name => 'Did you eat breakfast?', :survey_id => test_survey.id})
    test_question2 = Question.create({:name => 'Is your stomach growling?', :survey_id => test_survey.id})
    expect(test_survey.questions).to eq [test_question1, test_question2]
  end

  it 'has many choices through question' do
    test_survey = Survey.create({:name => 'Are you hungry?'})
    test_question = Question.create({:name => 'What did you eat for breakfast?', :survey_id => test_survey.id})
    test_choice1 = Choice.create({:name => 'Waffles', :question_id => test_question.id})
    test_choice2 = Choice.create({:name => 'Pancakes', :question_id => test_question.id})
    expect(test_survey.choices).to eq [test_choice1, test_choice2]
  end
end
