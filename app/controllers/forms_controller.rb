class FormsController < ApplicationController
  def contact_message_request

  end

  def subscription_request

  end

  def order_service_request
    @order_service_request = OrderServiceRequest.new(params[:order_service_request])
    if request.post?
      if @order_service_request.valid?
        @order_service_request.save
        render json: @order_service_request, status: 201
      else
        render json: @order_service_request, status: 400
      end
    end
  end

  def vacancy_request
    @vacancy_request = VacancyRequest.new(params[:vacancy_request])
    if request.post?
      if @vacancy_request.valid?
        @vacancy_request.save
        render json: @vacancy_request, status: 201
      else
        render json: @vacancy_request, status: 400
      end
    end
  end
end