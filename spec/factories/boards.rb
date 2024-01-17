FactoryBot.define do
  factory :board do
    sequence :name do |n|
      "A Sample Name #{n}"
    end
    created_by { 'user@example.com' }
    width { rand(5..15) }
    height { rand(5..15) }
    mines_count { rand(1..15) }
  end
end