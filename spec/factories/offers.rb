FactoryBot.define do
  factory :offer do
    advertiser_name { Faker::Company.name }
    url { Faker::Internet.url }
    description { Faker::Lorem.sentences(number: 1) }
    starts_at { Faker::Time.between_dates(from: DateTime.now - 2, to: DateTime.now - 1) }
    ends_at { Faker::Time.between_dates(from: DateTime.now + 1, to: DateTime.now + 2) }
    premium { false }

    trait :started do
      starts_at { Faker::Time.between_dates(from: DateTime.now - 2, to: DateTime.now - 1) }
      ends_at { Faker::Time.between_dates(from: DateTime.now + 1, to: DateTime.now + 2) }
      state { 'enabled' }
    end

    trait :finished do
      starts_at { Faker::Time.between_dates(from: DateTime.now - 5, to: DateTime.now - 4) }
      ends_at { Faker::Time.between_dates(from: DateTime.now - 2, to: DateTime.now - 1) }
      state { 'disabled' }
    end

    trait :not_expires do
      starts_at { Faker::Time.between_dates(from: DateTime.now - 2, to: DateTime.now) }
      ends_at { '' }
    end

    trait :offer_premium do
      premium { true }
    end
  end
end