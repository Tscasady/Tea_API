class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.references :tea, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.bigint :price
      t.integer :status
      t.integer :frequency

      t.timestamps
    end
  end
end
