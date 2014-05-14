class ContentController < ApplicationController
  before_filter :authenticate_user!
  
  def silver
    unless current_user.user_stripe_token.blank?
      authorize! :view, :silver, :message => 'Access limited to Silver Plan subscribers.'
      Stripe.api_key = current_user.user_stripe_token
      @charges = Stripe::Charge.all

      @total_amount = 0
      @charges.each do |p|
        @total_amount += p.amount
      end
      @customers = Stripe::Customer.all
      gon.customers_count = @customers.count
      gon.total_amount = @total_amount/100.00
      gon.charges_count = @charges.count
      gon.charges = @charges
      gon.total_user = User.count


    end
  end

  def gold
    authorize! :view, :gold, :message => 'Access limited to Gold Plan subscribers.'
  end

  def platinum
    authorize! :view, :platinum, :message => 'Access limited to Platinum Plan subscribers.'
  end
end