FactoryBot.define do
  factory :user do
    name { "MyString" }
    username { "MyString" }
    email { "MyString" }
    phone { "MyString" }
    website { "MyString" }
    address { nil }
    company { nil }
  end
end
