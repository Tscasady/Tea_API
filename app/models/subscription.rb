class Subscription < ApplicationRecord
  belongs_to :tea
  belongs_to :customer

  enum status: %i[active cancelled]
end
