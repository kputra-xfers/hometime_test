module V1
  module Webhooks
    class ReservationsController < ApplicationController
      def create
        if params[:reservation_code]
          Payload1Interactor.call(params: params)
        else
          Payload2Interactor.call(params: params[:reservation])
        end

        render json: { status: "OK", message: "success" }, status: 200
      end
    end
  end
end
