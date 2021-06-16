FactoryBot.define do
  factory :user, class: User do
    nickname                   { 'koji' }
    email                      { Faker::Internet.free_email }
    password = '1a' + Faker::Internet.password(min_length: 6)
    password                   { password }
    password_confirmation      { password }
    last_name                  { '石川' }
    first_name                 { '浩二' }
    last_name_kana             { 'イシカワ' }
    first_name_kana            { 'コウジ' }
    birth_day                  { '1990-04-07' }
  end
end
