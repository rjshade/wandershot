FactoryGirl.define do
  factory :user do
    name "Anonymous User"
    email "anonymous.user@example.com"
    password "please"
    password_confirmation "please"
  end

  factory :story do
    user
    
    title "An Exciting Story"
    summary "Summary of the story"
  end

  factory :post do
    story

    title "Post title"
    text "Body of the post"

    address "Place name"
    latitude "45.0000"
    longitude "-60.0000"

    date {DateTime.now}
  end
end
