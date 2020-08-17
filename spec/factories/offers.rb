FactoryBot.define do
  factory :offer do
    advertiser_name { Faker::Company.name }
    url { Faker::Internet.url }
    description { Faker::Lorem.sentences(number: 1) }
    starts_at { Faker::Time.between_dates(from: Date.today - 2, to: Date.today - 1) }
    ends_at { Faker::Time.between_dates(from: Date.today + 1, to: Date.today + 2) }
    premium { false }

    trait :started do
      starts_at { Faker::Time.between_dates(from: Date.today - 2, to: Date.today - 1) }
      ends_at { Faker::Time.between_dates(from: Date.today + 1, to: Date.today + 2) }
      state { 'enabled' }
    end

    trait :finished do
      starts_at { Faker::Time.between_dates(from: Date.today - 5, to: Date.today - 4) }
      ends_at { Faker::Time.between_dates(from: Date.today - 2, to: Date.today - 1) }
      state { 'disabled' }
    end

    trait :not_expires do
      starts_at { Faker::Time.between_dates(from: Date.today - 2, to: Date.today) }
      ends_at { '' }
    end

    trait :offer_premium do
      premium { true }
    end
  end
end