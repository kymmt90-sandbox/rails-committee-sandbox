class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_error

  private

  def render_not_found_error(error)
    errors = [{ title: "#{error.model} not found", detail: error.id.to_s }]
    render json: { errors: errors }, status: :not_found
  end

  def render_invalid_params_error(object)
    invalid_params = object.errors.keys
    errors = invalid_params.map { |param| { title: 'Invalid parameter', detail: param.to_s } }
    render json: { errors: errors }, status: :unprocessable_entity
  end
end
