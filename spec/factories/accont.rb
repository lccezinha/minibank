FactoryGirl.define do
  factory :account do
    total 100
    sequence(:number) { |n| 5.times.map { rand(9) }.join }
  end
end