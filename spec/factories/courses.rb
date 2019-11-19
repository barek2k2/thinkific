FactoryBot.define do
  factory :course do
    name Faker::Lorem.sentence
    subtitle Faker::Lorem.sentence
    description Faker::Lorem.paragraph
    price Faker::Number.decimal(l_digits: 2, r_digits: 2)
    duration Faker::Number.decimal(l_digits: 1, r_digits: 1)
  end
end
