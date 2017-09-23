FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "foo#{n}@example.com" }
    name 'Foo Bar'
    age 27
  end
end
