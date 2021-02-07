require 'rails_helper'

feature 'Admin edits promotion' do

  scenario 'successfully' do
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                expiration_date: '22/12/2033', user: user)
    user = User.create!(email: 'rogerio@email.com', password: '123456')
    login_as user                                

    visit root_path
    click_on 'Promoções'
    click_on 'Natal'
    click_on 'Editar'
    fill_in 'Nome', with: 'Páscoa'
    fill_in 'Descrição', with: 'Promoção de Páscoa'
    fill_in 'Código', with: 'PASCOA10'
    fill_in 'Desconto', with: '15'
    fill_in 'Quantidade de cupons', with: '50'
    fill_in 'Data de término', with: '20/04/2045'
    click_on 'Enviar'

    expect(page).to have_content('Páscoa')
    expect(page).to have_content('Promoção de Páscoa')
    expect(page).to have_content('15,00%')

  end

  scenario 'attributes cannot be blank' do
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                expiration_date: '22/12/2033', user: user)
    user = User.create!(email: 'rogerio@email.com', password: '123456')
    login_as user
    visit root_path
    click_on 'Promoções'
    click_on 'Natal'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Desconto', with: ''
    fill_in 'Quantidade de cupons', with: ''
    fill_in 'Data de término', with: ''
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco', count: 5)
  end

  scenario 'code must be unique' do
    Promotion.create!(name: 'Páscoa', description: 'Promoção de Páscoa',
                                code: 'PASCOA10', discount_rate: 15, coupon_quantity: 90,
                                expiration_date: '30/04/2045', user: user)
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                expiration_date: '22/12/2033', user: user)
    user = User.create!(email: 'rogerio@email.com', password: '123456')
    login_as user                            

    visit root_path
    click_on 'Promoções'
    click_on 'Natal'
    click_on 'Editar'
    fill_in 'Código', with: 'PASCOA10'
    click_on 'Enviar'

    expect(page).to have_content('já está em uso')
  end
end
