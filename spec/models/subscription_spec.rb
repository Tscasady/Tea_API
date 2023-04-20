require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'relations' do
    it { should belong_to :tea }
    it { should belong_to :customer }
  end

  describe 'validations' do
    it { should validate_numericality_of :frequency }
    it { should validate_numericality_of :price }
  end
end
