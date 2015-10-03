FactoryGirl.define do
  factory :auction do
  
    association :user, factory: :user
    
    sequence(:title)         { |n| "#{Faker::Company.bs}-#{n}" }
    sequence(:details)       { Faker::Lorem.paragraph          }
    sequence(:reserve_price) { 10 + rand(1000)                 }
    sequence(:end_date_time) { Time.now + 30.days              }      
    sequence(:current_price) { 10                              }      
    aasm_state               :published

  end
end
