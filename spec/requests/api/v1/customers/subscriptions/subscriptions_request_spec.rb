require 'rails_helper'

RSpec.describe 'Customer Subscription API' do
  describe 'GET all subscriptions for a customer' do

    before(:each) do
      @customer = create(:customer)
    end
    
    it 'can return a list of subscriptions associated with a customer' do
      create_list(:subscription, 3, customer: @customer)

      get "/api/v1/customers/#{@customer.id}/subscriptions"

      sub_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(sub_data[:data]).to be_an Array
      expect(sub_data[:data].length).to eq 3
      sub_data[:data].each do |sub|
        expect(sub).to include(:id, :type, :attributes)
        expect(sub[:id]).to be_a String
        expect(sub[:type]).to eq 'subscription'
        expect(sub[:attributes][:title]).to be_a String
        expect(sub[:attributes][:price]).to be_a Numeric
        expect(sub[:attributes][:frequency]).to be_a Numeric
        expect(sub[:attributes][:status]).to eq 'active'
      end
    end

    it 'can return active and cancelled subscriptions' do
      create(:subscription, customer: @customer, status: 'active')
      create(:subscription, customer: @customer, status: 'cancelled')

      get "/api/v1/customers/#{@customer.id}/subscriptions"

      sub_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(sub_data[:data]).to be_an Array
      expect(sub_data[:data].length).to eq 2
      expect(sub_data[:data][0][:attributes][:status]).to eq 'active'
      expect(sub_data[:data][1][:attributes][:status]).to eq 'cancelled'
    end

    it 'can return an empty array if a customer has no subscriptions' do

      get "/api/v1/customers/#{@customer.id}/subscriptions"

      sub_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(sub_data[:data]).to be_an Array
      expect(sub_data[:data].length).to eq 0
    end

    it 'can return a 404 if an invalid customer id is given' do

      get '/api/v1/customers/9123941234/subscriptions'

      expect(response.status).to eq(404)
    end
  end
end
