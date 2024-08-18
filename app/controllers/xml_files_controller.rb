class XmlFilesController < ApplicationController
  before_action :authenticate_user!

  def new
    @xml_file = XmlFile.new
  end

  def create
    @xml_file = XmlFile.create!(xml_file_params)
    # Dispara Worker, passando o ID do objeto
    worker_file = XmlFile.find(@xml_file.id)

    worker_file.xml_files.blobs.each do |blob|
      # Conseguir o path do arquivo:
      path = "./storage/#{blob.key[0..1]}/#{blob.key[2..3]}/#{blob.key}"

      # Abrir o arquivo:
      file = File.read(path)
      # Arquivo Hash
      my_xml = Crack::XML.parse(file)

      
      # puts "\n\n\n\n"
      # puts "=====" * 20
      # pp my_xml
      # puts "=====" * 20
      # puts "\n\n\n\n"
    end
  end

  private

  def xml_file_params
    params.require(:xml_file).permit(xml_files: [])
  end
end
