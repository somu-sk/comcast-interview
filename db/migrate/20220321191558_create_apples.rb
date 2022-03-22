class CreateApples < ActiveRecord::Migration[7.0]
  def change
    create_table :apples do |t|
      t.references :basket, foreign_key: true
      t.string :variety
      t.timestamps
    end
  end
end
