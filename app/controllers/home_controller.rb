class HomeController < ApplicationController
  def index
  end

  def privacy_policy
  end

  def terms
  end

  def check_your_email
  end

  def sitemap
    redirect_to 'https://teensy-bit-production.s3.us-west-1.amazonaws.com/sitemaps/sitemap.xml.gz'
  end
end
