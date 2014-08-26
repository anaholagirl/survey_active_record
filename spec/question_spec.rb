require 'spec_helper'

describe Question do
  it 'belongs to survey' do
    test_survey = Survey.create({:name => 'Are you hungry?'})
    test_question = Question.create({:name => 'Did you eat breakfast?', :survey_id => test_survey.id })
    expect(test_question.survey).to eq test_survey
  end
end
