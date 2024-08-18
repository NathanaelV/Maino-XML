class AssembleTheEinvoiceJob < ApplicationJob
  queue_as :default

  def perform(einvoice)
    xml_file_text = File.read("public/xml_files/#{einvoice.file_name}")
    @my_xml = Crack::XML.parse(xml_file_text)
    create_ide(einvoice)
  end

  private

  def create_ide(einvoice)
    Ide.create(
      serie: @my_xml['NFe']['infNFe']['ide']['serie'],
      n_nf: @my_xml['NFe']['infNFe']['ide']['nNF'],
      dh_emi: @my_xml['NFe']['infNFe']['ide']['dhEmi'],
      einvoice:
    )
  end
end
