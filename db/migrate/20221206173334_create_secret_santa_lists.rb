class CreateSecretSantaLists < ActiveRecord::Migration[7.0]
  def change
    create_table :secret_santa_lists do |t|
      t.references :organizer, index:true, foreign_key: {to_table: :users}
      t.text :list_name

      t.timestamps
    end
  end
end
