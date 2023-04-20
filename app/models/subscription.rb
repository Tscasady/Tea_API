class Subscription < ApplicationRecord
  belongs_to :tea
  belongs_to :customer

  enum status: %i[active cancelled]

  validates_numericality_of :frequency
  validates_numericality_of :price
end
