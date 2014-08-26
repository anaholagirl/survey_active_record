require 'spec_helper'

describe Choice do
  it 'belongs to a question' do
    test_question = Question.create({:name => 'What is the meaning of life?'})
    test_choice = Choice.create({:name => 'To enjoy every candy bar!', :question_id => test_question.id})
    expect(test_choice.question).to eq test_question
  end
end
