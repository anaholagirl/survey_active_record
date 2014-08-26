require 'spec_helper'

describe Response do
  it 'belongs to choices' do
    test_question = Question.create({:name => 'What is your favorite color?'})
    test_choice1 = Choice.create({:name => 'Blue'})
    test_choice2 = Choice.create({:name => 'Green'})
    test_choice3 = Choice.create({:name => 'Red'})
    test_response = Response.create({:question_id => test_question.id, :choice_id => test_choice1.id})
    expect(test_response.choice).to eq test_choice1
  end
end
