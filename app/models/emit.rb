class Emit < ApplicationRecord
  belongs_to :einvoice
  has_one :ender_emit, dependent: :destroy
end
