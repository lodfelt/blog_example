
def test_file_path(file_name)
  Rails.root.join('spec', 'support', 'data', file_name)
end

include ActionDispatch::TestProcess

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

  factory :article_image do
    image { fixture_file_upload(test_file_path('rails.png'), 'image/png') }
    sequence :description do |n|
      "description_#{n}"
    end
  end

  factory :comment do
    sequence :name do |n|
      "name_#{n}"
    end
    sequence :email do |n|
      "test_#{n}@example.com"
    end
    sequence :body do |n|
      "body_#{n}"
    end
  end

end
