FactoryGirl.define do

  factory :user do
    sequence :email do |n|
      "user_#{n}@example.com"
    end
    sequence :password do |n|
      "password_#{n}"
    end

    factory :member do
    end

    factory :admin do
      role_ids [1]
    end

    factory :visitor do
      role_ids []
    end
  end

  factory :article do
    sequence :title do |n|
      "title_#{n}"
    end
    sequence :body do |n|
      "body_#{n}"
    end

    factory :published do
      published true
    end
  end

end
