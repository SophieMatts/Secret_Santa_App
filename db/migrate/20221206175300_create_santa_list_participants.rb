class CreateSantaListParticipants < ActiveRecord::Migration[7.0]
  def change
    create_table :santa_list_participants do |t|
      t.references :list_id, index:true, foreign_key: {to_table: :secret_santa_lists}
      t.references :sender_id, index:true, foreign_key: {to_table: :users}
      t.references :receiver_id, index:true, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
