module JsonRpc
  module Logger
    attr_writer :logger
    def logger
      @logger ||= Logging.logger[self]
    end
  end

  class Error < StandardError
    attr_reader :code, :message, :data

    def initialize(code, message, data = nil)
      @code = code
      @message = message
      @data = data
      super(message)
    end

    def to_s
      "Code #{code}: #{super}" + (@data ? " (#{@data.inspect})" : "")
    end
  end

  class BadJsonReceivedError < Error
    def initialize(data = nil)
      super(-32603, "Bad JSON received", data)
    end
  end

  class UnexpectedMessageIdError < Error
    def initialize(data = nil)
      super(-32603, "Unexpected Message ID", data)
    end
  end

  class NoResultOrError < Error
    def initialize(data = nil)
      super(-32603, "Neither Result nor Error received", data)
    end
  end
end
