class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.text :first_name
      t.text :last_name
      t.text :user_name
      t.text :password
      t.text :wish_list

      t.timestamps
    end
  end
end
