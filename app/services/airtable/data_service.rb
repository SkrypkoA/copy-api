module  Airtable
  require "net/http"
  require "uri"

  class DataService
    TABLE_ID = "Table%201"
    APP_ID = "appQG8i3HVB2QhznY"


    def initialize
      @url = URI.parse "https://api.airtable.com/v0/#{APP_ID}/#{TABLE_ID}"
      @http ||= Net::HTTP.new(@url.host, @url.port)
      @http.use_ssl = true
    end

    def refresh_data
      File.open("public/copy.json", "w") do |file|
        file.write(data)
      end
    end

    def data
      response = @http.request(request)
      if response.code == '200'
        response.body
      else
        Rails.logger.fatal "Airtable API error! #{response.body}"
        '{ "records": [] }'
      end
    end

    def request
      request = Net::HTTP::Get.new(@url)
      request["Authorization"] = "Bearer #{ENV["AIRTABLEKEY"]}"
      request
    end
  end
end