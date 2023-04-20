class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def render_not_found_response(exception)
    render json: ErrorSerializer.serialize_error(exception, :not_found, 'Record not Found'), status: :not_found
  end
end
