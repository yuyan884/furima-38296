class Destination < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # Association
  belongs_to :history    # Historyモデル
  belongs_to :prefecture # ActiveHash
end
