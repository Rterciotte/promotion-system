require 'rails_helper'

feature 'Admin searches promotion' do
    scenario 'and find exact match' do
        promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                    code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                    expiration_date: '22/12/2033', user: user)
        user = User.create!(email: 'rogerio@email.com', password: '123456')
        login_as user                                    
        visit root_path
        click_on 'Promoções'
        fill_in 'Busca de promoção', with: promotion.name
        click_on 'Buscar'

        expect(page).to have_content('Natal')
        expect(page).to have_content('Promoção de Natal')
        expect(page).to have_content('10,00%')

    end
    
    scenario 'and finds nothing' do
        promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                    code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                    expiration_date: '22/12/2033', user: user)
        user = User.create!(email: 'rogerio@email.com', password: '123456')
        login_as user                                    
        visit root_path
        click_on 'Promoções'
        fill_in 'Busca de promoção', with: 'Páscoa'
        click_on 'Buscar'

        expect(page).not_to have_content('Natal')
        expect(page).not_to have_content('Promoção de Natal')
        expect(page).not_to have_content('10,00%')

    end

    scenario 'finds by partial name' do
        promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                    code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                    expiration_date: '22/12/2033', user: user)
        user = User.create!(email: 'rogerio@email.com', password: '123456')
        login_as user
        visit root_path
        click_on 'Promoções'
        fill_in 'Busca de promoção', with: 'Nat'
        click_on 'Buscar'

        expect(page).to have_content('Natal')
        expect(page).to have_content('Promoção de Natal')
        expect(page).to have_content('10,00%')
    end
end