module Api
  module Default
    extend ActiveSupport::Concern
    included do
      include Helpers::Common
      content_type :json, 'application/json'
      content_type :xml, 'application/xml'
      content_type :txt, 'text/plain'
      content_type :binary, 'application/octet-stream'
      default_format :json
      version 'v1', using: :path

      rescue_from NoMethodError do |e|
        error!({code:1, error: 'not found'}, 422)
      end
    end
  end
end