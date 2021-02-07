require 'rails_helper'

feature 'Admin deletes a promotion' do
    scenario 'successfully' do
      promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                   code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                   expiration_date: '22/12/2033', user: user)
      user = User.create!(email: 'rogerio@email.com', password: '123456')
      login_as user                                    
      visit root_path
      click_on 'Promoções'
      click_on 'Natal'
      click_on 'Apagar'
  
      expect(current_path).to eq promotions_path
      expect(page).to have_content('Nenhuma promoção cadastrada')
    end
  
    scenario 'and keep anothers' do

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
      click_on 'Apagar'
  
      expect(current_path).to eq promotions_path
      expect(page).not_to have_content('Natal')
      expect(page).to have_content('Páscoa')
    end
  end