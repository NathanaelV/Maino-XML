require 'rails_helper'

describe 'User sends XML file' do
  before { freeze_time }
  after { unfreeze_time }

  it 'successfully' do
    user = create(:user)
    xml_file = fixture_file_upload('test_file.xml', 'text/xml')
    einvoices_params = { einvoice: { xml_file: } }

    file_name = "#{Time.now.to_i}-test_file.xml"
    path = Rails.public_path.join("/public/xml_files/#{file_name}").to_s
    root_xml_path = "#{RSPEC_ROOT_TEST}#{path}"
    allow(File).to receive(:binwrite).with(root_xml_path, xml_file.read)

    login_as user
    post '/einvoices', params: einvoices_params

    expect(flash.notice).to eq 'XML salvo com sucesso.'
    expect(Einvoice.last.xml_file).to be_attached
    expect(response).to redirect_to root_path
  end

  it 'if authentication' do
    einvoices_params = { einvoice: { xml_files: '' } }

    post '/einvoices', params: einvoices_params

    expect(flash.alert).to eq 'Para continuar, faça login ou registre-se.'
    expect(response).to redirect_to new_user_session_path
  end

  it 'does not save' do
    user = create(:user)
    einvoices_params = { einvoice: { xml_files: fixture_file_upload('test_file.xml', 'text/xml') } }
    allow_any_instance_of(Einvoice).to receive(:save).and_return(false)

    login_as user
    post '/einvoices', params: einvoices_params

    expect(flash.alert).to eq 'Erro ao salvar XML, tente novamente.'
  end
end
