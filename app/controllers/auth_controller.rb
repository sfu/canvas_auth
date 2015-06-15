class AuthController < ApplicationController
  skip_before_filter :verify_authenticity_token, :load_user

  def auth
    if request.remote_ip != '142.58.101.11' && request.remote_ip != '142.58.3.148'
      render json: { error_code: 404, error_message: "No such route exists." } , status: 404
      return
    end

    authenticated = false

    # check params present
    required_fields = %w(username password)
    return (render json: { error_code: 400, error_message: "Missing required params." }, status: 400 ) unless required_fields.all? { |k| params[k].present? }

    begin
      # basic user check
      hash = { :unique_id => params[:username], :password => params[:password] }
      pseudonym_session = @domain_root_account.pseudonym_sessions.new(hash)
      
      # should never be nil but we check anyways
      if pseudonym_session.nil?
        return (render json: { error_code: 500, error_message: "Null pseudonym_session." }, status: 500)
      end
      authenticated = pseudonym_session.valid?
    
      if !authenticated
        # check among pseudonyms
        pseudonym = Pseudonym.authenticate(hash, @domain_root_account.trusted_account_ids, request.remote_ip)
        authenticated = !pseudonym.nil?
      end
    
    rescue => e
      return (render json: { error_code: 500, error_message: e.message })
    end

    render json: { authenticated: authenticated ? "YES" : "NO" }
  end
end
