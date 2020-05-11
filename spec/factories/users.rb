FactoryBot.define do
  factory :user do
    encrypted_password = Faker::Internet.password(min_length: 8)
    username {Faker::Name.name}
    email {Faker::Internet.free_email}
    password {encrypted_password}
    password_confirmation {encrypted_password}
  end
end