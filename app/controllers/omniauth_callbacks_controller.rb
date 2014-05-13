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


    Stripe.api_key = token
    User.find_or_create_by_email(user.email)
  end
end
