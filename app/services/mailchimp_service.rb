class MailchimpService
  require 'faraday'
  require 'digest'

  attr_reader :params, :api_key, :unique_id, :user_details, :response, :url

  def initialize(params)
    @params = params
    @api_key = ENV['MAILCHIMP_API_KEY']
    @unique_id = ENV['MAILCHIMP_UNIQUE_ID']
    dc = ENV['MAILCHIMP_DC']
    @url = "https://#{dc}.api.mailchimp.com/3.0/lists/#{unique_id}/members"
    # You need to pass the status:subscribed field to ensure the user is subscribed
    name_array = params[:name].split(" ")
    fname = name_array[0]
    lname = name_array[1]
    @user_details = {
      email_address: params[:email],
      status: "subscribed",
      merge_fields: {
        FNAME: fname,
        LNAME: lname,
      },
    }
  end

  def base_url
    "https://gateway.marvel.com/v1/public"
  end

  def base_connection
    Faraday.new(
      url: url,
      headers: {'Content-Type' => 'application/json', 'Authorization': "Bearer #{api_key}"}
    )
  end

  def create_new_subscriber
    connection = base_connection
    @response = connection.post() do |req|
      req.body = @user_details.to_json
    end
    @response
  end

  def unsubscribe
    subscriber_hash = Digest::MD5.new
    subscriber_hash << user_details[:email_address]
    connection = base_connection
    connection[:url] += "/#{subscriber_hash}"
    @response = base_connection.put() do |req|
      req.body = { status: "unsubscribed" }.to_json
    end
    @response
  end

end