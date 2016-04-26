module Metrics
  class RequestTimings

    def initialize(headers, params, action_start)
      @headers = headers
      @params = params
      @action_start = action_start
      @current_time = Time.now
    end

    def queuing
      difference(request_start, middleware_start)
    end

    def middleware
      difference(middleware_start, action_start)
    end

    def controller
      difference(action_start, current_time)
    end

    def request_id
      @request_id ||= client_request_id || SecureRandom.hex(10)
    end

    private

    def difference(sooner, later)
      later - sooner if sooner && later
    end

    def parse_timestamp(timestamp)
      Time.at(timestamp.to_f / 1000) if timestamp.present?
    end

    attr_reader :headers, :params, :action_start, :current_time

    def client_request_id
      params[:request_timings] && params[:request_timings][:client_request_id]
    end

    def request_start
      parse_timestamp(headers['HTTP_X_REQUEST_START'])
    end

    def middleware_start
      parse_timestamp(headers['HTTP_X_MIDDLEWARE_START'])
    end

  end
end
