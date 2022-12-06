class SecretSantaList < ApplicationRecord
  belongs_to :user
  has_many :santa_list_participants
end
