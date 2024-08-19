class Item < ApplicationRecord
  belongs_to :det
  has_one :prod, dependent: :destroy
  has_one :imposto, dependent: :destroy
end
