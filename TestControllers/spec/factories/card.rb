FactoryBot.define do
  factory :card do
    sequence(:word) { |i| "Word-#{i}" }
    sequence(:translation) { |i| "Translation-#{i}" }
  end
end