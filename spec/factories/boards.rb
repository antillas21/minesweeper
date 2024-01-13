FactoryBot.define do
  factory :board do
    name { 'A Sample Name' }
    created_by { 'user@example.com' }
    width { 10 }
    height { 10 }
    mines_count { 10 }
  end
end