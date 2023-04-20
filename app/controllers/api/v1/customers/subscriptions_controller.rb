class Api::V1::Customers::SubscriptionsController < ApplicationController
  def index
    customer = Customer.includes(:subscriptions).find(params[:customer_id])
    render json: SubscriptionSerializer.new(customer.subscriptions)
  end
end
