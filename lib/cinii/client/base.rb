# frozen_string_literal: true

require 'cinii/errors'

module Cinii
  class Client
    class Base
      def initialize(app_id: nil)
        @app_id = app_id
      end

      def send_get(path, params = nil)
        send_request(:get, path, params)
      end

      def has_required_params?(params, required_keys)
        !!required_keys.find { |p| params[p] }
      end

      private

        def send_request(method, path, params = nil)
          params = params ? default_params.merge(params) : default_params
          response = cinii_connection.send(method, path, params)
          raise RemoteURLNotAvailableError, "#{path} is not available." unless response.status == 200
          response
        end

        def cinii_connection
          @cinii_connection ||= Faraday.new(faraday_options) do |con|
            con.request  :json
            con.response :json
            con.response :logger do | logger |
              logger.filter(/(appid=)(\w+)/,'\1[REMOVED]')
            end
            con.adapter  Faraday.default_adapter
          end
        end

        def default_params
          {
            appid:  app_id,
            format: 'json'
          }
        end

        def faraday_options
          {
            url: faraday_url,
            headers: faraday_headers
          }
        end

        def faraday_url
          'https://ci.nii.ac.jp'
        end

        def faraday_headers
          {
            'Accept'       => 'application/json',
            'User-Agent'   => "Cinii Ruby Gem #{Cinii::VERSION}"
          }
        end

        def app_id
          @app_id || ENV['CINII_APP_ID']
        end
    end
  end
end
