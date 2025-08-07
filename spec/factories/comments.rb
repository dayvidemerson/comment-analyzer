FactoryBot.define do
  factory :comment do
    name { "MyString" }
    email { "MyString" }
    body { "MyText" }
    translated_body { "MyText" }
    post { nil }
  end
end
