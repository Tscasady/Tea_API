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

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(404)
      expect(error_data[:message]).to eq 'Record not Found'
      expect(error_data[:errors][0][:detail]).to eq "Couldn't find Customer with 'id'=9123941234"
    end
  end

  describe 'POST customer subscription' do

    before(:each) do
      @customer = create(:customer)
    end

    it 'can create a new subscription for a customer with a default status of active' do
      tea = create(:tea)
      sub_params = {
        tea_id: tea.id,
        title: 'Green Tea Subscription',
        price: 5.00,
        frequency: 2
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }
      post "/api/v1/customers/#{@customer.id}/subscriptions", headers: headers, params: JSON.generate(sub_params)

      sub_data = JSON.parse(response.body, symbolize_names: true)

      sub = Subscription.last

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(sub_data[:data][:id]).to eq sub.id.to_s
      expect(sub_data[:data][:type]).to eq 'subscription'
      expect(sub_data[:data][:attributes][:title]).to eq "Green Tea Subscription"
      expect(sub_data[:data][:attributes][:price]).to eq 5.00
      expect(sub_data[:data][:attributes][:frequency]).to eq 2
      expect(sub_data[:data][:attributes][:status]).to eq 'active'
    end

    it 'can return a 404 if the given customer doesnt exist' do

      post '/api/v1/customers/1231348932/subscriptions'

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 404
      expect(error_data[:message]).to eq 'Record not Found'
      expect(error_data[:errors][0][:detail]).to eq "Couldn't find Customer with 'id'=1231348932"
    end

    it 'can return a 422 if invalid subscription data is given' do
      tea = create(:tea)
      sub_params = {
        tea_id: tea.id,
        title: 'Green Tea Subscription',
        price: 'not a price',
        frequency: 2
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }
      post "/api/v1/customers/#{@customer.id}/subscriptions", headers: headers, params: JSON.generate(sub_params)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 400
      expect(error_data[:message]).to eq 'Record Invalid'
      expect(error_data[:errors][0][:detail]).to eq 'Validation failed: Price is not a number'
    end
  end

  describe 'PATCH customer subscriptions' do

    before(:each) do
      @customer = create(:customer)
    end

    it 'can cancel an active subscription' do
      tea = create(:tea)
      sub = create(:subscription, tea: tea, customer: @customer)

      headers = { 'CONTENT_TYPE' => 'application/json' }
      patch "/api/v1/customers/#{@customer.id}/subscriptions/#{sub.id}", headers: headers, params: JSON.generate({tea_id: tea.id})

      sub_data = JSON.parse(response.body, symbolize_names: true)

      sub = Subscription.last

      expect(sub.status).to eq 'cancelled'

      expect(response.status).to eq 200
      expect(sub_data[:data][:id]).to eq sub.id.to_s
      expect(sub_data[:data][:type]).to eq 'subscription'
      expect(sub_data[:data][:attributes][:title]).to eq sub.title
      expect(sub_data[:data][:attributes][:price]).to eq sub.price
      expect(sub_data[:data][:attributes][:frequency]).to eq sub.frequency
      expect(sub_data[:data][:attributes][:status]).to eq 'cancelled'
    end

    it 'can return a status 404 if customer doesnt exist' do
      tea = create(:tea)
      sub = create(:subscription, tea: tea, customer: @customer)

      headers = { 'CONTENT_TYPE' => 'application/json' }
      patch "/api/v1/customers/1231348932/subscriptions/#{sub.id}", headers: headers, params: JSON.generate({tea_id: tea.id})

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 404
      expect(error_data[:message]).to eq 'Record not Found'
      expect(error_data[:errors][0][:detail]).to eq "Couldn't find Customer with 'id'=1231348932"

    end

    it 'can return a status 404 if subscription doesnt exist' do
      tea = create(:tea)

      headers = { 'CONTENT_TYPE' => 'application/json' }
      patch "/api/v1/customers/#{@customer.id}/subscriptions/12312321", headers: headers, params: JSON.generate({tea_id: tea.id})

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 404
      expect(error_data[:message]).to eq 'Record not Found'
      expect(error_data[:errors][0][:detail]).to eq "Couldn't find Subscription with 'id'=12312321"
    end
  end
end
