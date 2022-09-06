FactoryBot.define do
  factory :history do
    association :user
    association :item
  end
end
