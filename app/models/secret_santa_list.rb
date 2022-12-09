class SecretSantaList < ApplicationRecord
  belongs_to :organizer, :class_name => 'User', foreign_key: "organizer_id"
  has_many :santa_list_participants, foreign_key: "list_id_id"
end
