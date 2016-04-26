require Rails.root.join('lib/metrics/print_request_timings')
require Rails.root.join('lib/metrics/request_timings')

class ApiExternalController < ApplicationController

  before_filter :set_action_start_timing
  after_filter :print_request_timings

  skip_before_action :verify_authenticity_token

  def blank_api
    sleep(0.01)
    response = { synccode: 0, size: params[:random_data].bytesize }
    render json: response

  end

  def set_action_start_timing
    @action_start = Time.now
  end

  def print_request_timings
    ::Metrics::PrintRequestTimings.call(request.headers, params, @action_start)
  end

end
