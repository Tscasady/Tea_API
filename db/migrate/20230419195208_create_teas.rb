class CreateTeas < ActiveRecord::Migration[7.0]
  def change
    create_table :teas do |t|
      t.string :title
      t.string :description
      t.float :temperature
      t.float :brew_time

      t.timestamps
    end
  end
end
