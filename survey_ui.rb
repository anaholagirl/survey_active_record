require 'active_record'
require './lib/question'
require './lib/survey'
require 'pry'


database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  puts "Welcome to Survey World!"
  puts "Press 'a' to enter survey menu."
  puts "Press 't' to take a survey."
  puts "Pres 'x' to exit this world."
  choice = gets.chomp.downcase
  if choice == 'a'
    survey_menu
  elsif choice == 't'
    take_survey
  elsif choice == 'x'
    exit
  else
    puts "We like valid answers only."
  end
end

def survey_menu
  puts "Press 'a' to create a survey."
  puts "Press 'l' to list all existing surveys."
  puts "Press 'd' to delete a survey."
  puts "Press 'q' to add questions to a survey"
  puts "Press 'v' to view a survey."
  puts "Press 'm' to return to main menu"
  choice = gets.chomp.downcase

  if choice == 'a'
    create_survey
  elsif choice == 'l'
    list_surveys
  elsif choice == 'd'
    delete_survey
  elsif choice == 'q'
    add_questions
  elsif choice == 'v'
    view_survey
  elsif choice == 'm'
    welcome
  else
    puts "Validity is what you seek. Try again."
  end
end

def create_survey
  puts "What is the survey to be called?"
  survey_name = gets.chomp
  new_survey = Survey.create({:name => survey_name})
  puts " '#{new_survey.name}' survey has been created!"
  survey_menu
end

def list_surveys
  puts "Here are all the surveys:"
  surveys = Survey.all
  surveys.each {|survey| puts survey.name}
  survey_menu
end

def delete_survey
  puts "Here are all the surveys:"
  surveys = Survey.all
  surveys.each {|survey| puts survey.name}

  puts "Which survey would you like to delete?"
  delete_choice = gets.chomp
  survey_to_delete = Survey.where({:name => delete_choice}).first
  survey_to_delete.delete
  survey_menu
end

def add_questions
  puts "Here are all the surveys:"
  surveys = Survey.all
  surveys.each {|survey| puts survey.name}
  puts "Which survey would you like to add questions to??"
  survey_choice = gets.chomp
  selected_survey = Survey.where({:name => survey_choice}).first
  puts "What question would you like to add to this survey?"
  question_choice = gets.chomp
  question = Question.create({:name => question_choice, :survey_id => selected_survey.id})
  survey_menu
end

def view_survey
  puts "Which survey would you like to view?"
  surveys = Survey.all
  surveys.each {|survey| puts survey.name}
  survey_choice = gets.chomp
  selected_survey = Survey.where({:name => survey_choice}).first
  # survey_questions = Question.where({:survey_id => selected_survey.id}).first
  puts "Here are all your questions:"
  selected_survey.questions
  selected_survey.questions.each do |question|
    puts question.name
  end
  survey_menu
end


welcome
