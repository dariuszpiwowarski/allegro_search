require 'allegro/webapi'
class AllegroApi
  include Singleton

  def initialize
    @client = Allegro::WebApi::Client.new do |config|
      config.user_login = Rails.configuration.x.allegro_api.user_login
      config.password = Rails.configuration.x.allegro_api.password
      config.webapi_key = Rails.configuration.x.allegro_api.webapi_key
      config.country_code = Rails.configuration.x.allegro_api.country_code
      config.local_version = Rails.configuration.x.allegro_api.local_version
    end
    @client.login
  end

  def categories
    return @categories if !@categories.nil?
    message = {country_id: @client.country_code, local_version: 0, webapi_key: @client.webapi_key}
    res = @client.call(:do_get_cats_data, message: message)
    @categories = res.to_hash[:do_get_cats_data_response][:cats_list][:item]
  end

  def search(search_string, options)
    begin
      search = Allegro::WebApi::Search.new(@client)
      res = search.search_query(search_string, options)
    rescue Exception => e
      if e.message =~ /ERR_NO_SESSION/
        @client.login
      end
      res = search.search_query(search_string, options)
    end
  end
end
