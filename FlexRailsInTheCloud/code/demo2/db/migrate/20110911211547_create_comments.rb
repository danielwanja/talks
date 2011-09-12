class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :post_id
      t.string :email
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
