FactoryBot.define do
  factory :user do
    email {Faker::Internet.email}
    password {Faker::Internet.password} 

    factory :confirmed_user do
      before(:create) {|user| user.skip_confirmation! }
    end  

    trait :admin_user do
      after(:create) {|user| user.add_role('admin')}
    end

    trait :new_user do
      after(:create) {|user| user.add_role('newuser')}
    end

  end
end