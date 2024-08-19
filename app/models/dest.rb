class Dest < ApplicationRecord
  belongs_to :einvoice
  has_one :ender_dest, dependent: :destroy
end
