require 'rails_helper'

describe 'Visitor view home' do
  it 'successfully' do
    visit root_path

    expect(page).to have_content 'Seja bem-vindo, Faça login para continuar'
  end
end
