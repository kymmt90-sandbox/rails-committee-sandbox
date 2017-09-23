class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_error

  private

  def render_not_found_error(error)
    errors = [{ title: "#{error.model} not found", detail: error.id.to_s }]
    render json: { errors: errors }, status: :not_found
  end
end
