require 'rails_helper'

describe 'User sends XML file' do
  it 'successfully' do
    user = create(:user)
    xml_file_params = { xml_file: { xml_files: [fixture_file_upload('test_file.xml', 'text/xml')] } }

    login_as user
    post '/xml_files', params: xml_file_params

    expect(flash.notice).to eq 'XML salvo com sucesso.'
    expect(XmlFile.last.xml_files).to be_attached
  end

  it 'if authentication' do
    xml_file_params = { xml_files: [] }

    post '/xml_files', params: xml_file_params

    expect(flash.alert).to eq 'Para continuar, faça login ou registre-se.'
    expect(response).to redirect_to new_user_session_path
  end

  it 'does not save' do
    user = create(:user)
    xml_file_params = { xml_file: { xml_files: [fixture_file_upload('test_file.xml', 'text/xml')] } }
    allow_any_instance_of(XmlFile).to receive(:save).and_return(false)

    login_as user
    post '/xml_files', params: xml_file_params

    expect(flash.alert).to eq 'Erro ao salvar XML, tente novamente.'
  end
end
