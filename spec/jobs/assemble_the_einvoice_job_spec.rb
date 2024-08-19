require 'rails_helper'

RSpec.describe AssembleTheEinvoiceJob, type: :job do
  it 'should assemble the einvoice' do
    einvoice = create(:einvoice, file_name: 'test_file.xml')

    AssembleTheEinvoiceJob.perform_now(einvoice)

    einvoice_answer = Einvoice.last
    expect(einvoice_answer.ide.serie).to eq '4'
    expect(einvoice_answer.ide.n_nf).to eq '500778'
    expect(einvoice_answer.ide.dh_emi).to eq '2024-08-12T14:21:59-03:00'

    expect(einvoice_answer.emit.cnpj).to eq '60124452000107'
    expect(einvoice_answer.emit.x_nome).to eq 'MAINO SISTEMAS DE INFORMATICA LTD'
    expect(einvoice_answer.emit.x_fant).to eq 'MAINO SISTEMAS'
    expect(einvoice_answer.emit.ie).to eq '78205377'
    expect(einvoice_answer.emit.crt).to eq '3'

    expect(einvoice_answer.emit.ender_emit.x_lgr).to eq 'RUA MARCOS MORO'
    expect(einvoice_answer.emit.ender_emit.nro).to eq '16'
    expect(einvoice_answer.emit.ender_emit.x_cpl).to eq 'SL 808'
    expect(einvoice_answer.emit.ender_emit.x_bairro).to eq 'SAO FRANCISCO'
    expect(einvoice_answer.emit.ender_emit.c_mun).to eq '3304557'
    expect(einvoice_answer.emit.ender_emit.x_mun).to eq 'RIO DE JANEIRO'
    expect(einvoice_answer.emit.ender_emit.uf).to eq 'RJ'
    expect(einvoice_answer.emit.ender_emit.cep).to eq '80530080'
    expect(einvoice_answer.emit.ender_emit.c_pais).to eq '1058'
    expect(einvoice_answer.emit.ender_emit.x_pais).to eq 'BRASIL'
    expect(einvoice_answer.emit.ender_emit.fone).to eq '211234567899'

    expect(einvoice_answer.dest.cnpj).to eq '08370779000149'
    expect(einvoice_answer.dest.x_nome).to eq 'MAINO CLIENTE'
    expect(einvoice_answer.dest.ind_ie_dest).to eq '9'

    expect(einvoice_answer.dest.ender_dest.x_lgr).to eq 'Rua Augusta, 50'
    expect(einvoice_answer.dest.ender_dest.nro).to eq '50'
    expect(einvoice_answer.dest.ender_dest.x_bairro).to eq 'Consolacao'
    expect(einvoice_answer.dest.ender_dest.c_mun).to eq '3550308'
    expect(einvoice_answer.dest.ender_dest.x_mun).to eq 'SAO PAULO'
    expect(einvoice_answer.dest.ender_dest.uf).to eq 'SP'
    expect(einvoice_answer.dest.ender_dest.cep).to eq '01305901'
    expect(einvoice_answer.dest.ender_dest.c_pais).to eq '1058'
    expect(einvoice_answer.dest.ender_dest.x_pais).to eq 'BRASIL'

    expect(einvoice_answer.det.item.first.prod.x_prod).to eq 'Batata frita'
    expect(einvoice_answer.det.item.first.prod.ncm).to eq '02013000'
    expect(einvoice_answer.det.item.first.prod.cfop).to eq '6102'
    expect(einvoice_answer.det.item.first.prod.u_com).to eq 'BALDE'
    expect(einvoice_answer.det.item.first.prod.q_com).to eq '100.0000'
    expect(einvoice_answer.det.item.first.prod.v_un_com).to eq '25.0000000000'

    expect(einvoice_answer.det.item.first.imposto.v_icms).to eq '330.00'
    expect(einvoice_answer.det.item.first.imposto.v_ipi).to eq '250.00'

    expect(einvoice_answer.det.item.second.prod.x_prod).to eq 'BALAO ESTRELA'
    expect(einvoice_answer.det.item.second.prod.ncm).to eq '34013000'
    expect(einvoice_answer.det.item.second.prod.cfop).to eq '6102'
    expect(einvoice_answer.det.item.second.prod.u_com).to eq 'UN'
    expect(einvoice_answer.det.item.second.prod.q_com).to eq '1.0000'
    expect(einvoice_answer.det.item.second.prod.v_un_com).to eq '2.0600000000'

    expect(einvoice_answer.det.item.second.imposto.v_icms).to eq '0.25'
    expect(einvoice_answer.det.item.second.imposto.v_ipi).to eq ''

    expect(einvoice_answer.det.item.length).to eq(2)

    expect(einvoice_answer.total.v_icms).to eq '330.25'
    expect(einvoice_answer.total.v_ipi).to eq '250.00'
    expect(einvoice_answer.total.v_pis).to eq '0.00'
    expect(einvoice_answer.total.v_cofins).to eq '0.00'
    expect(einvoice_answer.total.v_nf).to eq '2752.06'
    expect(einvoice_answer.total.v_tot_trib).to eq '405.00'

    expect(einvoice_answer.id_nfe).to eq 'NFe33240860124452000107550040005007781056116414'
    expect(einvoice_answer.version).to eq '4.00'
  end

  it 'should assemble the einvoice second' do
    einvoice = create(:einvoice, file_name: 'test_file2.xml')

    AssembleTheEinvoiceJob.perform_now(einvoice)

    einvoice_answer = Einvoice.last
    expect(einvoice_answer.det.item.first.prod.x_prod).to eq '6"*10.97MM - 5749MM TUBO DE ACO CARBONO SOLDADO, NAO LIGADO, PADRAO ASTM A214, DE SECAO CIRCULAR, COM SOLDA POR RESISTEN'

    expect(einvoice_answer.det.item.first.imposto.v_icms).to eq '2.22'
    expect(einvoice_answer.det.item.first.imposto.v_ipi).to eq '1.75'

    expect(einvoice_answer.det.item.second.imposto.v_icms).to eq '118.44'
    expect(einvoice_answer.det.item.second.imposto.v_ipi).to eq ''

    expect(einvoice_answer.det.item.third.imposto.v_icms).to eq '432.00'
    expect(einvoice_answer.det.item.third.imposto.v_ipi).to eq ''
  end
end
