FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Pascal_#{n}" }
    sequence(:email) { |n| "pascal_#{n}@batman.com"}
    password "scandale"
    password_confirmation "scandale"

    factory :admin do
    	admin true
      ninja true
    end
  end

   factory :question do
  	content "What is time?"
  	user
  end