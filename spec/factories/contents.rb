FactoryBot.define do
  factory :content do
    title Faker::Lorem.sentence
    content_type Content.content_types.keys.sample
    description Faker::Lorem.sentences
  end
end
