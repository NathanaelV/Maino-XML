require 'rails_helper'

describe 'User sends XML file' do
  it 'successfully' do
    user = create(:user)
    einvoices_params = { einvoice: { xml_file: fixture_file_upload('test_file.xml', 'text/xml') } }

    login_as user
    post '/einvoices', params: einvoices_params

    expect(flash.notice).to eq 'XML salvo com sucesso.'
    expect(Einvoice.last.xml_file).to be_attached
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
