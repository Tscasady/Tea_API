# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

tea1 = Tea.create(title: 'White Tea', description: 'good tea', temperature: 180.5, brew_time: 2.5)
tea2 = Tea.create(title: 'Earl Grey', description: 'english tea', temperature: 195.0, brew_time: 3)
tea3 = Tea.create(title: 'Jasmine', description: 'another green tea', temperature: 185, brew_time: 2.75)
tea4 = Tea.create(title: 'Rooibos', description: 'herbal tea', temperature: 208, brew_time: 6.15)
customer1 = Customer.create(first_name: 'John', last_name: 'Smith', email: 'test@email.com', address: '123 location st.')
customer2 = Customer.create(first_name: 'Jane', last_name: 'Smith', email: 'test2@email.com', address: '124 test st.')
customer3 = Customer.create(first_name: 'Ant', last_name: 'O', email: 'test3@email.com', address: '126 road st.')
customer4 = Customer.create(first_name: 'Test', last_name: 'User', email: 'test4@email.com', address: '127 home st.')
Subscription.create(tea: tea1, customer: customer1, price: 5.00, status: 'active', frequency: 1)
Subscription.create(tea: tea2, customer: customer1, price: 5.50, status: 'cancelled', frequency: 2)
Subscription.create(tea: tea3, customer: customer1, price: 5.00, status: 'active', frequency: 3)
Subscription.create(tea: tea2, customer: customer2, price: 6.50, status: 'active', frequency: 4)
Subscription.create(tea: tea1, customer: customer2, price: 6.50, status: 'active', frequency: 2)
Subscription.create(tea: tea3, customer: customer3, price: 3.75, status: 'cancelled', frequency: 3)
Subscription.create(tea: tea1, customer: customer3, price: 3.75, status: 'cancelled', frequency: 5)
Subscription.create(tea: tea4, customer: customer4, price: 10.15, status: 'active', frequency: 2)
