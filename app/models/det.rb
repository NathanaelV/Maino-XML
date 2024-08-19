class Det < ApplicationRecord
  belongs_to :einvoice
  has_many :item, dependent: :destroy
end
