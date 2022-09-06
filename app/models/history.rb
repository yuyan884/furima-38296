class History < ApplicationRecord
  # Association
  belongs_to :user        # Userモデル
  belongs_to :item        # Itemモデル
  has_one    :destination # Destinationモデル
end
