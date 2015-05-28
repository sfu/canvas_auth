class AuthController < ApplicationController
  skip_before_filter :verify_authenticity_token, :load_user

  def auth
    found = false

    # basic user check
    hash = {:unique_id => params[:username], :password => params[:password]}
    pseudonym_session = @domain_root_account.pseudonym_sessions.new(hash)
    found = pseudonym_session.valid?
    
    if !found
      # check among pseudonyms
      pseudonym = Pseudonym.authenticate(hash, @domain_root_account.trusted_account_ids, request.remote_ip)
      found = !pseudonym.nil?
    end
   
    if found
      render json: {authenticated: "YES"}
    else
      render json: {authenticated: "NO"}
    end
  end
end
