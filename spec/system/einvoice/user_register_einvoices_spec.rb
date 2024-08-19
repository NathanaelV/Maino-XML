require 'rails_helper'

describe 'User register an XML file' do
  it 'if authenticated' do
    visit new_einvoice_path

    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
    expect(current_path).to eq new_user_session_path
  end

  it 'from homepage' do
    user = create(:user)

    login_as user
    visit root_path
    click_on 'Fazer upload de um XML'

    expect(page).to have_link 'Voltar', href: root_path
    expect(page).to have_field 'Arquivo XML', type: 'file'
    expect(page).to have_button 'Enviar'
  end
end
