class Api::V1::Customers::SubscriptionsController < ApplicationController
  def index
    customer = Customer.includes(:subscriptions).find(params[:customer_id])
    render json: SubscriptionSerializer.new(customer.subscriptions)
  end

  def create
    customer = Customer.find(params[:customer_id])
    render json: SubscriptionSerializer.new(customer.subscriptions.create!(subscription_params)), status: 201
  end

  def update
    customer = Customer.find(params[:customer_id])
    render json: SubscriptionSerializer.new(customer.subscriptions.update!(subscription_params))
  end

  private

  def subscription_params
    params.permit(:tea_id, :price, :title, :frequency)
  end
end
