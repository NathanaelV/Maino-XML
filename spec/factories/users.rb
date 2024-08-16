FactoryBot.define do
  factory :user do
    first_name { 'Donatello' }
    last_name { 'Hamato' }
    email { 'donatello.hamato@tmnt.com' }
    password { 'donatello123' }
  end
end
