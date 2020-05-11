FactoryBot.define do
  factory :comment do
    comment {Faker::Lorem.sentence}
    image {File.open("#{Rails.root}/public/image_sakura.jpg")}
    user
    group
  end
end