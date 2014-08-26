require 'spec_helper'

describe Survey do
  it 'has_many questions' do
    test_survey = Survey.create({:name => 'Are you hungry?'})
    test_question1 = Question.create({:name => 'Did you eat breakfast?'})
    test_question2 = Question.create({:name => 'Is your stomach growling?'})
    expect(test_survey.questions).to eq [test_question1, test_question2]
  end
end
