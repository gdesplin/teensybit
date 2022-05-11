
include ActionDispatch::TestProcess
FactoryBot.define do
  factory :document do
    daycare { nil }
    title { Faker::Lorem.word }
    description {Faker::Lorem.words }
    public_to_daycare { false }
    user { nil }
    document { Rack::Test::UploadedFile.new('spec/factories/files/test-picture.jpg', 'image/jpeg') }
  end
end
