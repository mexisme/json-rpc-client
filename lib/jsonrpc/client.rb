module JsonRpc
  class Client
    include Logger

    attr_reader :connection, :rpc_id, :update_params

    def self.connect(uri, &p)
      self.new(Faraday.new(uri), &p)
    end

    # @param connection
    # @param update_params [Proc]
    #        A call-back that will update the arg-list before it's passed via HTTP, e.g. to add authentication params
    def initialize(connection, &update_params)
      @connection = connection
      @update_params = update_params || ->(args) { args }

      next_rpc_id
    end

    def call(method, *args)
      next_rpc_id
      logger.debug "RPC #{method.inspect} #{args.inspect}"

      begin
        response = connection.call(json_rpc_request(method, args))
      rescue ::JSON::ParserError
        raise BadJsonReceivedError
      end

      logger.debug "Response = #{response.inspect}"

      err = response["error"]
      raise Error.new(err["code"], err["message"], err["data"]) if err

      raise UnexpectedMessageIdError.new([response["id"], rpc_id]) unless response["id"].to_s == rpc_id.to_s
      raise NoResultOrError unless response.key? "result"

      response["result"]
    end

    private

    def json_rpc_request(method, args)
      { jsonrpc: "2.0",
        id: rpc_id,
        method: method,
        params: update_params.call(args)
      }
    end

    def next_rpc_id
      @rpc_id = SecureRandom.uuid
    end
  end
end
