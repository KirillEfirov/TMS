FactoryBot.define do
  factory :folder do
    sequence(:name) { |i| "Folder-#{i}" }
  end
end