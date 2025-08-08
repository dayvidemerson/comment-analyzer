class User < ApplicationRecord
  belongs_to :address
  belongs_to :company

  has_many :posts, dependent: :destroy
end
