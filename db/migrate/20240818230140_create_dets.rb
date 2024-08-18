class CreateDets < ActiveRecord::Migration[7.1]
  def change
    create_table :dets do |t|
      t.references :einvoice, null: false, foreign_key: true
      

      t.timestamps
    end
  end
end
