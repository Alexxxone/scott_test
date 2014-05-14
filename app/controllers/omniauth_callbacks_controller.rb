class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def stripe_connect
    # Delete the code inside of this method and write your own.
    # The code below is to show you where to access the data.
    #raise request.env["omniauth.auth"].to_yaml
    logger.info request.env["omniauth.auth"].to_yaml
    logger.info '*'*10
    logger.info params[:stripeToken]
    logger.info '*'*10
    logger.info request.env["omniauth.auth"]['uid']
    logger.info '*'*10
    logger.info request.env["omniauth.auth"]['credentials']['token']
    logger.info '*'*10
    token = request.env["omniauth.auth"]['credentials']['token']
    user = Stripe::Account.retrieve(token)

#   token = 'sk_test_EE0ZPsE0fgoXUr6A60li5wQk'
#   Stripe.api_key = token
    puts user.email
    if User.find_by_email(user.email)
      @ex_user = User.find_by_email(user.email)
      @ex_user.user_stripe_token = token
      @ex_user.name = user.display_name
      @ex_user.save!
      sign_in_and_redirect @ex_user
    else
      new_password =  Devise.friendly_token[0,20]
      @new_user =  User.create!({email: user.email, name: user.display_name, user_stripe_token: token, password: new_password, password_confirmation: new_password })
      @new_user.roles << Role.where(name: 'silver')
      sign_in_and_redirect @new_user
    end
  end
end
