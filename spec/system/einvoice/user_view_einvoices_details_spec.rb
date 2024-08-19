require 'rails_helper'

describe 'User view einvoices details' do
  it 'successfully' do
    user = create(:user)

    login_as user
    visit root_path
    click_on
  end
end
