require 'aws-sdk-s3'
# Set the host name for URL creation

SitemapGenerator::Sitemap.default_host = "https://www.teensybit.com"
SitemapGenerator::Sitemap.sitemaps_host = "https://teensy-bit-sitemaps.s3.us-west-1.amazonaws.com/"
SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.sitemaps_path = '/'

SitemapGenerator::Sitemap.adapter = SitemapGenerator::AwsSdkAdapter.new(
  "teensy-bit-sitemaps",
  access_key_id: Rails.application.credentials.aws[:access_key_id],
  secret_access_key: Rails.application.credentials.aws[:secret_access_key],
  region: Rails.application.credentials.aws[:region]
)

SitemapGenerator::Sitemap.create do
    Daycare.find_each do |daycare|
      add daycare_path(daycare.friendly_id), :lastmod => daycare.updated_at
    end

    add '/terms'
    add '/privacy_policy'
end

