class AddStripeTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_stripe_token, :string
  end
end
