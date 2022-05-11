FactoryBot.define do
  factory :picture do
    daycare { nil }
    title { "MyString" }
    description { "MyString" }
    user { nil }
    public_to_daycare { false }
    picture { Rack::Test::UploadedFile.new('spec/factories/files/test-picture.jpg', 'image/jpeg') }
  end
end
