require 'spec_helper'

describe Choice do
  it 'belongs to a question' do
    test_question = Question.create({:name => 'What is the meaning of life?'})
    test_choice = Choice.create({:name => 'To enjoy every candy bar!', :question_id => test_question.id})
    expect(test_choice.question).to eq test_question
  end

  it 'has many responses' do
    test_question = Question.create({:name => 'What is the meaning of life?'})
    test_choice = Choice.create({:name => 'To be happy :)'})
    test_response = Response.create({:question_id => test_question.id, :choice_id => test_choice.id})
    expect(test_choice.responses).to eq [test_response]
  end
end
