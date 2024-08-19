class AssembleTheEinvoiceJob < ApplicationJob
  queue_as :default

  def perform(einvoice)
    xml_file_text = File.read("public/xml_files/#{einvoice.file_name}")
    @my_xml = Crack::XML.parse(xml_file_text)
    create_ide(einvoice)
    create_emit(einvoice)
    create_dest(einvoice)
    create_det(einvoice)
    create_total(einvoice)
    einvoice.update(id_nfe: @my_xml['NFe']['infNFe']['Id'])
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

  def create_dest(einvoice)
    dest = Dest.create(
      cnpj: @my_xml['NFe']['infNFe']['dest']['CNPJ'],
      x_nome: @my_xml['NFe']['infNFe']['dest']['xNome'],
      ind_ie_dest: @my_xml['NFe']['infNFe']['dest']['indIEDest'],
      einvoice:
    )
    create_ender_dest(dest)
  end

  def create_ender_dest(dest)
    EnderDest.create(
      x_lgr: @my_xml['NFe']['infNFe']['dest']['enderDest']['xLgr'],
      nro: @my_xml['NFe']['infNFe']['dest']['enderDest']['nro'],
      x_bairro: @my_xml['NFe']['infNFe']['dest']['enderDest']['xBairro'],
      c_mun: @my_xml['NFe']['infNFe']['dest']['enderDest']['cMun'],
      x_mun: @my_xml['NFe']['infNFe']['dest']['enderDest']['xMun'],
      uf: @my_xml['NFe']['infNFe']['dest']['enderDest']['UF'],
      cep: @my_xml['NFe']['infNFe']['dest']['enderDest']['CEP'],
      c_pais: @my_xml['NFe']['infNFe']['dest']['enderDest']['cPais'],
      x_pais: @my_xml['NFe']['infNFe']['dest']['enderDest']['xPais'],
      dest:
    )
  end

  def create_det(einvoice)
    det = Det.create(einvoice:)
    create_iten(det)
  end

  def create_iten(det)
    @my_xml['NFe']['infNFe']['det'].each do |file|
      item = Item.create(det:)
      create_prod(item, file)
      create_imposto(item, file)
    end
  end

  def create_prod(item, file)
    Prod.create(
      x_prod: file['prod']['xProd'],
      ncm: file['prod']['NCM'],
      cfop: file['prod']['CFOP'],
      u_com: file['prod']['uCom'],
      q_com: file['prod']['qCom'],
      v_un_com: file['prod']['vUnCom'],
      item:
    )
  end

  def create_imposto(item, file)
    Imposto.create(
      v_icms: file['imposto']['ICMS']['ICMS00']&.[]('vICMS') || '',
      v_ipi: file['imposto']['IPI']['IPITrib']&.[]('vIPI') || '',
      item:
    )
  end

  def create_total(einvoice)
    Total.create(
      v_icms: @my_xml['NFe']['infNFe']['total']['ICMSTot']['vICMS'],
      v_ipi: @my_xml['NFe']['infNFe']['total']['ICMSTot']['vIPI'],
      v_pis: @my_xml['NFe']['infNFe']['total']['ICMSTot']['vPIS'],
      v_cofins: @my_xml['NFe']['infNFe']['total']['ICMSTot']['vCOFINS'],
      v_nf: @my_xml['NFe']['infNFe']['total']['ICMSTot']['vNF'],
      v_tot_trib: @my_xml['NFe']['infNFe']['total']['ICMSTot']['vTotTrib'],
      einvoice:
    )
  end
end
