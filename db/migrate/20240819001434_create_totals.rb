class CreateTotals < ActiveRecord::Migration[7.1]
  def change
    create_table :totals do |t|
      t.references :einvoice, null: false, foreign_key: true
      t.string :v_icms
      t.string :v_ipi
      t.string :v_pis
      t.string :v_cofins
      t.string :v_nf
      t.string :v_tot_trib

      t.timestamps
    end
  end
end
