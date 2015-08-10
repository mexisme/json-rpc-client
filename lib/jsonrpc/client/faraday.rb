module JsonRpc
  class Client
    class Faraday
      include Logger

      attr_reader :uri

      def initialize(uri)
        @uri = uri
      end

      def connection
        @connection ||= ::Faraday.new(url: uri) do |c|
          logger.debug "Connecting to #{uri.inspect}..."

          c.request :json

          c.response :logger, logger.class[c]
          c.response :json, content_type: /\bjson$/

          # c.use :instrumentation

          c.use ::FaradayMiddleware::FollowRedirects, limit: 3
          c.use ::Faraday::Response::RaiseError # raise exceptions on 40x, 50x responses

          c.adapter :typhoeus
        end
      end

      # Send a JSON Request as a POST body
      # @param json_request [Hash|JSON]
      # @return [Hash|JSON] JSON response
      def call(json_request)
        response = connection.post do |r|
          r.body = json_request
          logger.debug "Request = #{r.inspect}"
        end

        response.body
      end
    end
  end
end
