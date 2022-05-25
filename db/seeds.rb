# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'json'

def add_tags_to_question(question, tag_list)
  tag_list.each do |tag_name|
    question.add_tag(tag_name)
  end
end

def add_votes_to_answer(users, answer, quantity_votes)
  users.first(quantity_votes).each do |user|
    answer.upvote_by user
  end
end

def add_votes_to_question(users, question, quantity_votes)
  users.first(quantity_votes).each do |user|
    question.upvote_by user
  end
end

def find_highest_votes(answers)
  answer_votes = []
  answers.each do |answer|
    votes = answer.get_upvotes.size
    answer_votes << votes
  end
  highest_votes = answer_votes.sort.last
  return highest_votes
end

puts "Cleaning database..."
puts Time.now.strftime("%I:%M %p")

University.destroy_all
User.destroy_all
Question.destroy_all
Answer.destroy_all

###### UNIVERSITIES ######

puts "Creating universities and institutions"
puts Time.now.strftime("%I:%M %p")

# institutions added to an array so that each institution id can be accessed later and associated to users
institutions = []

le_wagon = University.create!(
  name: "Le Wagon - Melbourne Campus",
  country: "Australia",
  location: "Melbourne, VIC, Australia"
)
institutions << le_wagon

filepath = 'db/institutions.json'
serialized_institutions = File.read(filepath)
institutions_json = JSON.parse(serialized_institutions)
institutions_json.first(200).each do |institution_json|
  institution = University.create!(
    name: institution_json['name'],
    location: institution_json['location'],
    country: institution_json['country']
  )
  institutions << institution
end
institutions_quantity = institutions.count
puts "Number of institutions created: #{institutions_quantity}"

###### USERS ######

puts "Creating users"
puts Time.now.strftime("%I:%M %p")

# users added to an array so that each user id can be accessed later and associated with a question or answer
users = []

puts "First creating connor, brian, ash and sarah"
connor = User.create!(
  email: "connor@test.com",
  password: 'password',
  display_name: "Connor Sanderson",
  first_name: "Connor",
  last_name: "Sanderson",
  about_me: "An engineer transitioning to software",
  university_id: institutions[0].id
)
connor.photo.attach(io: URI.open('https://avatars.githubusercontent.com/u/65951311?v=4'), filename: "#{connor.first_name.downcase}.jpeg", content_type: 'image/jpeg')
users << connor

brian = User.create!(
  email: "brian@test.com",
  password: 'password',
  display_name: "Brian Huynh",
  first_name: "Brian",
  last_name: "Huynh",
  about_me: "A Chemical Engineering who loves software development",
  university_id: institutions[1].id
)
brian.photo.attach(io: URI.open('https://avatars.githubusercontent.com/u/79491037?v=4'), filename: "#{connor.first_name.downcase}.jpeg", content_type: 'image/jpeg')
users << brian

ash = User.create!(
  email: "ashmeet@test.com",
  password: 'password',
  display_name: "Ashmeet K.",
  first_name: "Ashmeet",
  last_name: "Khurana",
  about_me: "HR Professional transitioning to tech",
  university_id: institutions[2].id
)
ash.photo.attach(io: URI.open('https://ca.slack-edge.com/T02NE0241-U02NNQD7729-fd716239206c-512'), filename: "#{connor.first_name.downcase}.jpeg", content_type: 'image/jpeg')
users << ash

sarah = User.create!(
  email: "sarah@test.com",
  password: 'password',
  display_name: "Sarah P",
  first_name: "Sarah",
  last_name: "Pelham",
  about_me: "Product Management Expert",
  university_id: institutions[3].id
)
sarah.photo.attach(io: URI.open('https://avatars.githubusercontent.com/u/59895692?v=4'), filename: "#{connor.first_name.downcase}.jpeg", content_type: 'image/jpeg')
users << sarah

# TO DO - Create Le Wagon and classmates as users
# use le_wagon.id as university id
# manon shearn
# paal ringstad
# glenn tippett
# thomas temple
# kathy tavia
# george kettle
# anja drayton
# fabrice Madre
# julian harrington
# luca severo
# jurek osada
# mariya rose panikulam
# mathieu longe
# Talina Bayeleva

# gregory Koutsantonis
# oliver barnes
# parisara Wongsethanoonoi
# rachel McNamara
# Saki Ota
# Shane Garland
# Tim Fawcett

puts "Now creating random users. This is slow. I set it to 100 so there could be more votes, takes about 4 mins"
puts Time.now.strftime("%I:%M %p")

filepath = 'db/user5000.json'
serialized_users = File.read(filepath)
users_json = JSON.parse(serialized_users)['results']

institution_id_counter = 4

users_json.first(100).each do |user_json|
  first_name = user_json['name']['first']
  last_name = user_json["name"]["last"]
  user = User.create!(
    email: user_json["email"],
    password: user_json["login"]["md5"],
    first_name: first_name,
    last_name: last_name,
    display_name: "#{first_name} #{last_name}",
    about_me: "",
    university_id: institutions[institution_id_counter].id
  )
  photo_url = user_json["picture"]["large"]
  user.photo.attach(io: URI.open(photo_url.to_s), filename: "#{user.first_name.downcase}.jpeg", content_type: 'image/jpeg')
  users << user
  # this updates the index that is accessed from the institutions array, thereby assigning a unique institution to each user
  institution_id_counter += 1
end

users_quantity = users.count
puts "Number of users created: #{users_quantity}"

###### POSTS ######

puts "creating posts with questions, answers, tags, and votes. Set this to 75"
puts Time.now.strftime("%I:%M %p")

filepath = 'db/posts.json'
serialized_posts = File.read(filepath)
posts_json = JSON.parse(serialized_posts)

questions = []
user_id_counter = 5

posts_json.first(75).each do |post_json|
  question = Question.create!(
    user_id: users[user_id_counter].id,
    created_at: post_json[0]["question_post_date"].to_datetime,
    title: post_json[0]["question_title"],
    content: post_json[0]["question_content"],
    is_archived: false
  )

  add_tags_to_question(question, post_json[0]["question_tags"])
  photo_url = post_json[0]["question_image_url"]
  unless photo_url.nil?
    question.photo.attach(io: URI.open(photo_url.to_s), filename: "#{question.user_id}.jpeg", content_type: 'image/jpeg')
  end

  questions << question
  puts "user id counter after question was made: #{user_id_counter}"
  if user_id_counter == users.length - 1
    user_id_counter = 0
  else
    user_id_counter += 1
  end
  puts "user id counter after question was made and add one to user id counter: #{user_id_counter}"

  answers = post_json[1]
  question_votes = 0
  answer_instances = []

  answers.each do |answer|
    votes = answer["answer_votes"].to_i
    puts "This answer has #{votes} votes"
    answer = Answer.create!(
      user_id: users[user_id_counter].id,
      question_id: questions.last.id,
      created_at: answer["answer_post_date"].to_datetime,
      content: answer["answer_content"],
      selected_answer: false,
      is_archived: false
    )

    add_votes_to_answer(users, answer, votes)
    question_votes += votes
    puts "now there are this many question_votes: #{question_votes}"

    photo_url = answer["answer_image_url"]
    unless photo_url.nil?
      answer.photo.attach(io: URI.open(photo_url.to_s), filename: "#{answer.user_id}.jpeg", content_type: 'image/jpeg')
    end

    puts "answer question id: #{answer.question_id}"
    puts answer
    puts answer.created_at

    answer_instances << answer
    puts "user id counter after answer was made: #{user_id_counter}"
    if user_id_counter == users.length - 1
      user_id_counter = 0
    else
      user_id_counter += 1
    end
    puts "user id counter after answer was made and add one to user id counter: #{user_id_counter}"
  end

  high_votes = find_highest_votes(answer_instances)

  answer_instances.each do |answer|
    if answer.get_upvotes.size == high_votes && answer.get_upvotes.size > 3
      answer.update!(selected_answer: true)
    end
  end

  puts "This is the total votes for the question: #{question_votes}"
  add_votes_to_question(users, question, question_votes)

  answer_quantity = answers.count
  puts "answer quantity: #{answer_quantity}"
  puts "user array length"
  puts users.length
end
puts "Added these questions and their answers"
puts questions
puts "Number of question answer posts created: #{questions.length}"
puts Time.now.strftime("%I:%M %p")


# Tag.create(name: "Psychology")
# Tag.create(name: "Math")
# Tag.create(name: "Physics")
# Tag.create(name: "Humour")
# Tag.create(name: "Chemistry")
# NEED TO HAVE LOGIC SO THAT MORE THAN ONE USER AT A SCHOOL, USERS HAVE MORE THAN ONE QUESTION, ANSWER EACH

# selected answer
# TAGS for question
# VOTES for questions and answers



# OLD SEED FILE

# question1 = Question.create!(
#   user_id: sarah.id,
#   content: "What are the core UX design principles I can apply to my product management role at google?",
#   is_archived: false
# )
# question1.photo.attach(io: File.open("#{Rails.root}/app/assets/images/bondi.jpg"), filename: 'my_image.png', content_type: 'image/jpeg')


#   user_id: brian.id,
#   question_id: question2.id,
#   content: "Suggest you work in the frequency domain",
#   selected_answer: false,
#   is_archived: false

  # created_at = "31 May, 2017".to_datetime
  # puts created_at
  # puts post_json

  # post = University.create!(
  #   name: institution_json['name'],
  #   location: institution_json['location'],
  #   country: institution_json['country']
  # )
  # posts << post


# anu = University.create!(
#   name: "Australian National University",
#   country: "Australia",
#   location: "Canberra ACT 2601"
# )

# uos = University.create!(
#   name: "University of Sydney",
#   country: "Australia",
#   location: "Camperdown NSW 2006"
# )

# melb = University.create!(
#   name: "University of Melbourne",
#   country: "Australia",
#   location: "Parkville VIC 3010"
# )

# uq = University.create!(
#   name: "University of Queensland",
#   country: "Australia",
#   location: "St Lucia QLD 4072"
# )

# puts "Finished creating universities"


# puts "Creating 4 users - Connor, Brian, Ash & Sarah. Password is 'password'. Username is first name all lowercase."

# connor = User.create!(
#   email: "connor@test.com",
#   password: 'password',
#   display_name: "connor",
#   first_name: "Connor",
#   last_name: "Sanderson",
#   about_me: "An engineer transitioning to software",
#   university_id: anu.id
# )

# connor.photo.attach(io: URI.open('https://avatars.githubusercontent.com/u/65951311?v=4'), filename: "#{connor.first_name.downcase}.jpeg", content_type: 'image/jpeg')

# brian = User.create!(
#   email: "brian@test.com",
#   password: 'password',
#   display_name: "brian",
#   first_name: "Brian",
#   last_name: "Huynh",
#   about_me: "A Chemical Engineering who loves software development",
#   university_id: uos.id
# )

# brian.photo.attach(io: URI.open('https://avatars.githubusercontent.com/u/79491037?v=4'), filename: "#{connor.first_name.downcase}.jpeg", content_type: 'image/jpeg')

# ash = User.create!(
#   email: "ashmeet@test.com",
#   password: 'password',
#   display_name: "ashmeet",
#   first_name: "Ashmeet",
#   last_name: "Khurana",
#   about_me: "HR Professional transitioning to tech",
#   university_id: melb.id
# )

# ash.photo.attach(io: URI.open('https://ca.slack-edge.com/T02NE0241-U02NNQD7729-fd716239206c-512'), filename: "#{connor.first_name.downcase}.jpeg", content_type: 'image/jpeg')

# sarah = User.create!(
#   email: "sarah.pelham@gmail.com",
#   password: 'password',
#   display_name: "sarah",
#   first_name: "Sarah",
#   last_name: "Pelham",
#   about_me: "Product Management Expert",
#   university_id: uq.id
# )

# sarah.photo.attach(io: URI.open('https://avatars.githubusercontent.com/u/59895692?v=4'), filename: "#{connor.first_name.downcase}.jpeg", content_type: 'image/jpeg')

# puts "finished creating users"
# puts "creating questions for ash, connor, sarah and brian"

# question1 = Question.create!(
#   user_id: sarah.id,
#   content: "What are the core UX design principles I can apply to my product management role at google?",
#   is_archived: false
# )
# question1.photo.attach(io: File.open("#{Rails.root}/app/assets/images/bondi.jpg"), filename: 'my_image.png', content_type: 'image/jpeg')

# question2 = Question.create!(
#   user_id: connor.id,
#   content: "How can I tackle this fourier series problem? See attached photo",
#   is_archived: false
# )

# question3 = Question.create!(
#   user_id: brian.id,
#   content: "How can I calculate the entropy of this chemical reaction?",
#   is_archived: false
# )

# question4 = Question.create!(
#   user_id: ash.id,
#   content: "What are the key human relations principles I should apply to this problem?",
#   is_archived: false
# )

# puts "finished creating questions, now creating answers"

# answer1 = Answer.create!(
#   user_id: connor.id,
#   question_id: question1.id,
#   content: "1. Hierarchy, 2. Consistency, 3. Confirmation, 4. User Control, 5. Accessibility. See this link I found 'https://careerfoundry.com/en/blog/ux-design/5-key-principles-for-new-ux-designers/'",
#   selected_answer: false,
#   is_archived: false
# )

# answer2 = Answer.create!(
#   user_id: brian.id,
#   question_id: question2.id,
#   content: "Suggest you work in the frequency domain",
#   selected_answer: false,
#   is_archived: false
# )

# answer3 = Answer.create!(
#   user_id: ash.id,
#   question_id: question3.id,
#   content: "Take a look at the Gibbs free energy formula. Maybe even the second law of thermodynamics",
#   selected_answer: false,
#   is_archived: false
# )

# answer4 = Answer.create!(
#   user_id: sarah.id,
#   question_id: question4.id,
#   content: "Recruitment and selection. Performance management. Learning and development. Succession planning. Compensation and benefits. Human resources information systems. HR data and analysis.",
#   selected_answer: false,
#   is_archived: false
# )

# puts "finished creating answers"
