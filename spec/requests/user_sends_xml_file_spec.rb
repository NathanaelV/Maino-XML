require 'rails_helper'

describe 'User sends XML file' do
  it 'successfully' do
    user = create(:user)
    xml_file_params = { xml_files: [] }

    login_as user
    post '/xml_files', params: xml_file_params
  end

  it 'without authentication' do
    xml_file_params = { xml_files: [] }

    post '/xml_files', params: xml_file_params

    expect(response).to redirect_to new_user_session_path
  end
end
