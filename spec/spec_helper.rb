require 'active_record'
require 'rspec'
require 'pg'
require 'survey'
require 'question'
require 'response'
require 'choice'


ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))['test'])

RSpec.configure do |config|
  config.after(:each) do
    Survey.all.each { |survey| survey.destroy }
    Question.all.each { |question| question.destroy }
    Response.all.each { |response| response.destroy}
    Choice.all.each { |choice| choice.destroy}
  end
end
