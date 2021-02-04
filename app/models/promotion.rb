class Promotion < ApplicationRecord
    has_many :coupons
    validates :name, :code, :discount_rate, :coupon_quantity, :expiration_date, presence: true
    validates :code, uniqueness: true
    validate :expiration_date_cannot_be_in_the_past, :discount_cannot_be_greater_than_total_value

    def generate_coupons!
      Coupon.transaction do  
        (1..coupon_quantity).each do |number|
            coupons.create!(code: "#{code}-#{'%04d' % number}")
        end
      end  
    end

    def expiration_date_cannot_be_in_the_past
        if expiration_date.present? && expiration_date < Date.today
          errors.add(:expiration_date, "can't be in the past")
        end
      end
    
    def discount_cannot_be_greater_than_total_value
        if discount_rate > 100
        errors.add(:discount_rate, "can't be greater than total value")
        end
    end
end
