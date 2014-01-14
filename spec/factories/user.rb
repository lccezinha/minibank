FactoryGirl.define do
  factory :user do |u|
    sequence(:name) {|n| "User ##{n}"}
    sequence(:email) {|n| "user#{n}#{Time.now.usec}@bank.com.br"}
    password "12345678"
    u.sequence(:cpf) { |n| n.to_s.rjust(11, '0') }
  end
end