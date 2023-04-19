require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relations' do
    it { should have_many :subscriptions }
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
  end
end
