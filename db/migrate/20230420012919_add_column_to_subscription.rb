class AddColumnToSubscription < ActiveRecord::Migration[7.0]
  def change
    add_column :subscriptions, :title, :string
  end
end
