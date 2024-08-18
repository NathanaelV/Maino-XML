class Einvoice < ApplicationRecord
  has_one_attached :xml_file
  has_one :ide, dependent: :destroy
  has_one :emit, dependent: :destroy
  has_one :dest, dependent: :destroy

  def xml_file=(value)
    file_name = "#{Time.now.to_i}-#{value.original_filename}"
    file_path = Rails.public_path.join('xml_files')
    path_with_file = "#{file_path}/#{file_name}"

    Dir.mkdir(file_path) unless Dir.exist?(file_path)
    File.binwrite(path_with_file, value.read)
    self.file_name = file_name

    super
  end
end
