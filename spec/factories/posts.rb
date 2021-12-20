FactoryBot.define do
  factory :post do
    association :user
    genre_id { Faker::Number.between(from: 1, to: 12) }
    title { Faker::Lorem.word }
    text { Faker::Lorem.sentence }
    reference { Faker::Internet.url }
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
