class User < ApplicationRecord
  has_many :secret_santa_lists, foreign_key: "organizer_id"
end
