require 'active_record'
require './lib/question'
require './lib/survey'
require './lib/choice'
require './lib/response'
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
  add_choices
end

def add_choices
  puts "Put 'add' to add choices or 'x' to return to survey menu."
  choice = gets.chomp
  if choice == 'x'
    survey_menu
  elsif choice == 'add'
    puts "Here are all your surveys:"
    surveys = Survey.all
    surveys.each {|survey| puts survey.name}
    puts "What survey would you like to edit?"
    survey_choice = gets.chomp
    selected_survey = Survey.where({:name => survey_choice}).first

    puts "Here are all your questions:"
    # questions = Question.where({:survey_id => selected_survey.id}).first
    selected_survey.questions
    selected_survey.questions.each do |question|
      puts question.name
    end
    puts "What question would you like to add choices to?"
    question_choice = gets.chomp
    @selected_question = Question.where({:name => question_choice}).first
    puts "What choice would you like to add?"
    user_choice = gets.chomp
    new_choice = Choice.create({:name => user_choice, :question_id => @selected_question.id})
    loop do
      puts "Would you like to 'add' another choice to this question or 'return' to survey menu?"
      response = gets.chomp
      if response == 'return'
        survey_menu
      elsif response == 'add'
        puts "What choice would you like to add?"
      user_choice = gets.chomp
      new_choice = Choice.create({:name => user_choice, :question_id => @selected_question.id})
      end
    end
  else
    puts "Try again sir/madam."
  end
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
  puts "Would you like to view your question choices, 'yes' or 'no'?"
  choice = gets.chomp
  if choice == 'yes'
    puts "What question would you like to examine?"
    response = gets.chomp
    question = Question.where({:name => response}).first
    # choices = Choice.where(:question_id => question).first
    # ******
    question.choices
    question.choices.each do |choice|
      puts choice.name
    end
  elsif choice == 'no'
    survey_menu
  end
end

def take_survey
  surveys = Survey.all
  surveys.each {|survey| puts survey.name}
  puts "What survey would you like to take??"
  survey_choice = gets.chomp
  selected_survey = Survey.where({:name => survey_choice}).first
  selected_survey.questions.each do |question|
    puts question.name
    choices = Choice.where({:question_id => question.id}).first
    choices.each_with_index do |choice, index|
      puts "#{index +1}. #{choice.name}"
    end
    puts "Enter the number of your choice:"
    choice = gets.chomp.to_i
    result = choices.all[choice-1]
    new_response = Response.create({:choice_id =>result.id, :question_id => question.id})
  end
  puts "Survey has been completed!!! Thank you!!"
  welcome
end

welcome
