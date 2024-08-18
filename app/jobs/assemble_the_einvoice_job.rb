class AssembleTheEinvoiceJob < ApplicationJob
  queue_as :default

  def perform(einvoice)
    xml_file_text = File.read("public/xml_files/#{einvoice.file_name}")
    @my_xml = Crack::XML.parse(xml_file_text)
    create_ide(einvoice)
    create_emit(einvoice)
    create_dest(einvoice)
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

  def create_emit(einvoice)
    emit = Emit.create(
      cnpj: @my_xml['NFe']['infNFe']['emit']['CNPJ'],
      x_nome: @my_xml['NFe']['infNFe']['emit']['xNome'],
      x_fant: @my_xml['NFe']['infNFe']['emit']['xFant'],
      ie: @my_xml['NFe']['infNFe']['emit']['IE'],
      crt: @my_xml['NFe']['infNFe']['emit']['CRT'],
      einvoice:
    )
    create_ender_emit(emit)
  end

  def create_ender_emit(emit)
    EnderEmit.create(
      x_lgr: @my_xml['NFe']['infNFe']['emit']['enderEmit']['xLgr'],
      nro: @my_xml['NFe']['infNFe']['emit']['enderEmit']['nro'],
      x_cpl: @my_xml['NFe']['infNFe']['emit']['enderEmit']['xCpl'],
      x_bairro: @my_xml['NFe']['infNFe']['emit']['enderEmit']['xBairro'],
      c_mun: @my_xml['NFe']['infNFe']['emit']['enderEmit']['cMun'],
      x_mun: @my_xml['NFe']['infNFe']['emit']['enderEmit']['xMun'],
      uf: @my_xml['NFe']['infNFe']['emit']['enderEmit']['UF'],
      cep: @my_xml['NFe']['infNFe']['emit']['enderEmit']['CEP'],
      c_pais: @my_xml['NFe']['infNFe']['emit']['enderEmit']['cPais'],
      x_pais: @my_xml['NFe']['infNFe']['emit']['enderEmit']['xPais'],
      fone: @my_xml['NFe']['infNFe']['emit']['enderEmit']['fone'],
      emit:
    )
  end
end
