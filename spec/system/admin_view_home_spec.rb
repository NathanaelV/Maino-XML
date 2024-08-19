require 'rails_helper'

describe 'User view home' do
  it 'if authenticated' do
    visit root_path

    expect(page).to have_content 'Seja bem-vindo!'
    expect(page).to have_content 'Faça login para continuar'
    expect(page).not_to have_content 'Fazer upload de um XML'
  end

  it 'successfully' do
    user = create(:user)

    login_as user
    visit root_path

    expect(page).to have_content 'Fazer upload de um XML'
    expect(page).to have_button 'Sair'
    expect(page).not_to have_content 'Faça login para continuar'
  end
end
