FactoryBot.define do
  factory :message do
    content { Faker::Quotes::Shakespeare.hamlet_quote }
    image { File.open("#{Rails.root}/public/images/test_image.jpg") }
    user
    group
  end
end
