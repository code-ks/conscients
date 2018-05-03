# frozen_string_literal: true

class Checkout::CouponToOrderAdditionsController < ApplicationController
  def create
    @coupon = Coupon.find_by('name ILIKE ?', params[:name])
    @cart.coupon = @coupon
    if @coupon && @cart.save
      redirect_back fallback_location: new_delivery_path,
                    notice: t('flash.coupon_to_order_additions.create.notice')
    else
      redirect_back fallback_location: new_delivery_path,
                    alert: t('flash.coupon_to_order_additions.create.alert')
    end
  end
end
