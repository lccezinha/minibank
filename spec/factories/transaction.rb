FactoryGirl.define do
  factory :transaction do |u|
    operation 'entry'
    quantity 50
  end
end