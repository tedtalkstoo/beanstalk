class ApiExternalController < ApplicationController

  skip_before_action :verify_authenticity_token

  def blank_api
    render json: {}.to_json
  end

end
