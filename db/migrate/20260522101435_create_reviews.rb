class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :user
      t.references :movie
      t.text :comment
      t.integer :rating

      t.timestamps
    end
  end
end
