# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'

puts "Cleaning database..."

University.destroy_all
User.destroy_all
Question.destroy_all
Answer.destroy_all

puts "creating four universities"

anu = University.create!(
  name: "Australian National University",
  country: "Australia",
  location: "Canberra ACT 2601"
)

uos = University.create!(
  name: "University of Sydney",
  country: "Australia",
  location: "Camperdown NSW 2006"
)

melb = University.create!(
  name: "University of Melbourne",
  country: "Australia",
  location: "Parkville VIC 3010"
)

uq = University.create!(
  name: "University of Queensland",
  country: "Australia",
  location: "St Lucia QLD 4072"
)

puts "Finished creating four universities"
puts "Creating 4 users - Connor, Brian, Ash & Sarah. Password is 'password'. Username is first name all lowercase."

connor = User.create!(
  email: "connor@test.com",
  password: 'password',
  display_name: "connor",
  first_name: "Connor",
  last_name: "Sanderson",
  about_me: "An engineer transitioning to software",
  university_id: anu.id
)

connor.photo.attach(io: URI.open('https://avatars.githubusercontent.com/u/65951311?v=4'), filename: "#{connor.first_name.downcase}.jpeg", content_type: 'image/jpeg')

brian = User.create!(
  email: "brian@test.com",
  password: 'password',
  display_name: "brian",
  first_name: "Brian",
  last_name: "Huynh",
  about_me: "A Chemical Engineering who loves software development",
  university_id: uos.id
)

brian.photo.attach(io: URI.open('https://avatars.githubusercontent.com/u/79491037?v=4'), filename: "#{connor.first_name.downcase}.jpeg", content_type: 'image/jpeg')

ash = User.create!(
  email: "ashmeet@test.com",
  password: 'password',
  display_name: "ashmeet",
  first_name: "Ashmeet",
  last_name: "Khurana",
  about_me: "HR Professional transitioning to tech",
  university_id: melb.id
)

ash.photo.attach(io: URI.open('https://ca.slack-edge.com/T02NE0241-U02NNQD7729-fd716239206c-512'), filename: "#{connor.first_name.downcase}.jpeg", content_type: 'image/jpeg')

sarah = User.create!(
  email: "sarah.pelham@gmail.com",
  password: 'password',
  display_name: "sarah",
  first_name: "Sarah",
  last_name: "Pelham",
  about_me: "Product Management Expert",
  university_id: uq.id
)

sarah.photo.attach(io: URI.open('https://avatars.githubusercontent.com/u/59895692?v=4'), filename: "#{connor.first_name.downcase}.jpeg", content_type: 'image/jpeg')

puts "finished creating users"
puts "creating questions for ash, connor, sarah and brian"

question1 = Question.create!(
  user_id: sarah.id,
  content: "What are the core UX design principles I can apply to my product management role at google?",
  is_archived: false
)

question2 = Question.create!(
  user_id: connor.id,
  content: "How can I tackle this fourier series problem? See attached photo",
  is_archived: false
)

question3 = Question.create!(
  user_id: brian.id,
  content: "How can I calculate the entropy of this chemical reaction?",
  is_archived: false
)

question4 = Question.create!(
  user_id: ash.id,
  content: "What are the key human relations principles I should apply to this problem?",
  is_archived: false
)

puts "finished creating questions, now creating answers"

answer1 = Answer.create!(
  user_id: connor.id,
  question_id: question1.id,
  content: "1. Hierarchy, 2. Consistency, 3. Confirmation, 4. User Control, 5. Accessibility. See this link I found 'https://careerfoundry.com/en/blog/ux-design/5-key-principles-for-new-ux-designers/'",
  selected_answer: false,
  is_archived: false
)

answer2 = Answer.create!(
  user_id: brian.id,
  question_id: question2.id,
  content: "Suggest you work in the frequency domain",
  selected_answer: false,
  is_archived: false
)

answer3 = Answer.create!(
  user_id: ash.id,
  question_id: question3.id,
  content: "Take a look at the Gibbs free energy formula. Maybe even the second law of thermodynamics",
  selected_answer: false,
  is_archived: false
)

answer4 = Answer.create!(
  user_id: sarah.id,
  question_id: question4.id,
  content: "Recruitment and selection. Performance management. Learning and development. Succession planning. Compensation and benefits. Human resources information systems. HR data and analysis.",
  selected_answer: false,
  is_archived: false
)

puts "finished creating answers"
