class SantaListParticipant < ApplicationRecord
  belongs_to :secret_santa_list
  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'


end
