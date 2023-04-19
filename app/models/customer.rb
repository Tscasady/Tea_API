class Customer < ApplicationRecord
  has_many :subscriptions

  validates_presence_of :email
  validates_uniqueness_of :email
end
