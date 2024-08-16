require 'rails_helper'

describe 'User sings in' do
  it 'successfully' do
    User.create!(first_name: 'Donatello', last_name: 'Hamato', email: 'donatello.hamato@tmnt.com', password: 'donatello123')

    visit root_path
    click_on 'login'
    fill_in 'E-mail',	with: 'donatello.hamato@tmnt.com'
    fill_in 'Senha',	with: 'donatello123'
    click_on 'Logar'

    expect(page).to have_content 'Login efetuado com sucesso'
  end
end
