module Metrics
  class PrintRequestTimings
    def self.call(*args)
     new(*args).call
    end

    def initialize(*args)
      @timings = Metrics::RequestTimings.new(*args)
    end

    def call
      message('queuing', timings.queuing)
      message('middleware', timings.middleware)
      message('controller', timings.controller)
    end

    private

    attr_reader :timings

    def message(type, value)
      return unless value
      formatted_value = '%.6f' % value.round(6)
      puts "request_timing[#{type}] #{formatted_value} #{timings.request_id}"
      Rails.logger.info "request_timing[#{type}] #{formatted_value} #{timings.request_id}"
    end

  end
end
