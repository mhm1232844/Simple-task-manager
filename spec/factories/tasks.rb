# spec/factories/tasks.rb
FactoryBot.define do
  factory :task do
    # Use Faker for realistic default data
    title { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph(sentence_count: 2) }
    due_date { Faker::Date.forward(days: 30) }
    completed { false } # Default state

    # Define a trait for completed tasks
    trait :completed do
      completed { true }
    end

    # Define a trait for incomplete tasks (useful for clarity)
    trait :incomplete do
      completed { false }
    end
  end
end