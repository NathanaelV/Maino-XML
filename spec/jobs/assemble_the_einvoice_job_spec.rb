require 'rails_helper'

RSpec.describe AssembleTheEinvoiceJob, type: :job do
  it 'should assemble the einvoice' do
    einvoice = create(:einvoice, file_name: 'test_file.xml')

    AssembleTheEinvoiceJob.perform_now(einvoice)

    einvoice_answer = Einvoice.last
    expect(einvoice_answer.ide.serie).to eq '4'
    expect(einvoice_answer.ide.n_nf).to eq '500778'
    expect(einvoice_answer.ide.dh_emi).to eq '2024-08-12T14:21:59-03:00'
  end
end
