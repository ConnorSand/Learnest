# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'

puts "Cleaning database..."

# University.destroy_all
# User.destroy_all
# Question.destroy_all
# Answer.destroy_all

# ###### UNIVERSITIES ######

# puts "creating universities"

# filepath = 'db/institutions.json'
# serialized_institutions = File.read(filepath)
# institutions_json = JSON.parse(serialized_institutions)
# institutions = []
# institutions_json.each do |institution_json|
#   institution = University.create!(
#     name: institution_json['name'],
#     location: institution_json['location'],
#     country: institution_json['country']
#   )
#   institutions << institution
# end

# ###### USERS ######

# puts "creating users"

# users = []

# puts "first creating connor, brian, ash and sarah"
# connor = User.create!(
#   email: "connor@test.com",
#   password: 'password',
#   display_name: "Connor Sanderson",
#   first_name: "Connor",
#   last_name: "Sanderson",
#   about_me: "An engineer transitioning to software",
#   university_id: institutions[0].id
# )
# connor.photo.attach(io: URI.open('https://avatars.githubusercontent.com/u/65951311?v=4'), filename: "#{connor.first_name.downcase}.jpeg", content_type: 'image/jpeg')
# users << connor

# brian = User.create!(
#   email: "brian@test.com",
#   password: 'password',
#   display_name: "Brian Huynh",
#   first_name: "Brian",
#   last_name: "Huynh",
#   about_me: "A Chemical Engineering who loves software development",
#   university_id: institutions[1].id
# )
# brian.photo.attach(io: URI.open('https://avatars.githubusercontent.com/u/79491037?v=4'), filename: "#{connor.first_name.downcase}.jpeg", content_type: 'image/jpeg')
# users << brian

# ash = User.create!(
#   email: "ashmeet@test.com",
#   password: 'password',
#   display_name: "Ashmeet K.",
#   first_name: "Ashmeet",
#   last_name: "Khurana",
#   about_me: "HR Professional transitioning to tech",
#   university_id: institutions[2].id
# )
# ash.photo.attach(io: URI.open('https://ca.slack-edge.com/T02NE0241-U02NNQD7729-fd716239206c-512'), filename: "#{connor.first_name.downcase}.jpeg", content_type: 'image/jpeg')
# users << ash

# sarah = User.create!(
#   email: "sarah@test.com",
#   password: 'password',
#   display_name: "Sarah P",
#   first_name: "Sarah",
#   last_name: "Pelham",
#   about_me: "Product Management Expert",
#   university_id: institutions[3].id
# )
# sarah.photo.attach(io: URI.open('https://avatars.githubusercontent.com/u/59895692?v=4'), filename: "#{connor.first_name.downcase}.jpeg", content_type: 'image/jpeg')
# users << sarah

# puts "now creating 1000 random users"
# filepath = 'db/user5000.json'
# serialized_users = File.read(filepath)
# users_json = JSON.parse(serialized_users)['results']

# institution_id_counter = 4

# users_json.first(1000).each do |user_json|
#   first_name = user_json['name']['first']
#   last_name = user_json["name"]["last"]
#   user = User.create!(
#     email: user_json["email"],
#     password: user_json["login"]["md5"],
#     first_name: first_name,
#     last_name: last_name,
#     display_name: "#{first_name} #{last_name}",
#     about_me: "",
#     university_id: institutions[institution_id_counter].id
#   )
#   photo_url = user_json["picture"]["large"]
#   user.photo.attach(io: URI.open("#{photo_url}"), filename: "#{user.first_name.downcase}.jpeg", content_type: 'image/jpeg')
#   users << user
#   institution_id_counter += 1
# end

###### POSTS ######

puts "creating posts with questions, answers, tags, and votes"

filepath = 'db/posts.json'
serialized_posts = File.read(filepath)
posts_json = JSON.parse(serialized_posts)

# posts = []
posts_json.first(5).each do |post_json|
  created_at = post_json[0]["question_post_date"].to_datetime
  puts created_at
  title = post_json[0]["question_title"]
  puts title
  image = post_json[0]["question_image_url"]
  puts image unless image.nil?
  question = post_json[0]["question_content"]
  puts question
  tags = post_json[0]["question_tags"]
  puts tags
  # answer_quantity = post_json[1]["count"]
  # puts answer_quantity
  answers = post_json[1]
  answers.each do |answer|
    created_at = answer["answer_post_date"]
    puts created_at
    content = answer["answer_content"]
    puts content
    image = answer["answer_image_url"]
    puts image unless image.nil?
    votes = answer["answer_votes"]
    puts votes
  end
  answer_count = answers.count
  puts answer_count
end

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



# Old Seed

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
