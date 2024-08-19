class RenameXmlFileToEinvoice < ActiveRecord::Migration[7.1]
  def self.up
    rename_table :xml_files, :einvoices
  end

  def self.down
    rename_table :einvoices, :xml_files
  end
end
