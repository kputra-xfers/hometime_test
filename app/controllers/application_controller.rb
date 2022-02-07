class ApplicationController < ActionController::API
  rescue_from StandardError, with: :show_errors

  private

  def show_errors(e)
    Rails.logger.warn({ message: e.message, trace: e.backtrace })

    if Rails.env.production? || Rails.env.test?
      render json: { status: "Failed", message: e.message }, status: 422
    else
      raise e
    end
  end
end
