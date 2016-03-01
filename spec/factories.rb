FactoryGirl.define do
  factory :vet do
    name "Fiona's Favorite Vet"
    url "www.ffv.com"
    address "1234 W South St Seattle, WA 98103"
    email "info@ffv.com"
    user_id 1
  end
  factory :user do
    username "Fiona"
    uid "1234567"
    provider "google"
    email "a@b.com"
  end

end
