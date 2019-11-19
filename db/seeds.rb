# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Creating user..."
user = User.find_by(email: 'barek2k2@gmail.com')
unless user.present?
  user = User.create(
    email: 'barek2k2@gmail.com',
    password: '123456',
    password_confirmation: '123456'
  )
end

puts "Creating courses..."
course = Course.find_or_create_by(
  user_id: user.id,
  name: "Data Structure",
  subtitle: "Advanced Data structure from novice to professional",
  description: "Advanced Data structure from novice to professional, Advanced Data structure from novice to professional",
  price: 19.25,
  duration: 5.6,
)

puts "Creating chapters..."
chapter1 = Chapter.find_or_create_by(
  title: 'Chapter#1',
  course_id: course.id,
  rank: 1
)
chapter2 = Chapter.find_or_create_by(
  title: 'Chapter#2',
  course_id: course.id,
  rank: 1
)

puts "Creating content(s) with multimedia...."
content = Content.find_or_create_by(
  chapter_id: chapter1.id,
  title: "Introduction to data structure",
  content_type: 'pdf',
  description: 'lorem ipsum dolor site tope.',
  rank: 1
)

if content.files.count.zero?
  content.files.attach(io: open("#{Rails.root}/spec/files/file-sample_150kB.pdf"), filename: 'file-sample_150kB.pdf')
  content.save
end

content = Content.find_or_create_by(
  chapter_id: chapter1.id,
  title: "Basic knowledge of how data is designed",
  content_type: 'audio',
  description: 'lorem ipsum dolor site tope.',
  rank: 2
)

if content.files.count.zero?
  content.files.attach(io: open("#{Rails.root}/spec/files/file_example_MP3_700KB.mp3"), filename: 'file_example_MP3_700KB.mp3')
  content.save
end

puts "All set. Now you can login with email: #{user.email} and password: #{user.password} to play around :-)"