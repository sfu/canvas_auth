if File.exists? ('config/canvas_auth.yml')
  WL_CONFIG = YAML.load_file('config/canvas_auth.yml')
else
  Rails.logger.error "Error loading canvas_auth.yml config file. File not found."
  WL_CONFIG = nil
end

class AuthController < ApplicationController
  skip_before_filter :verify_authenticity_token, :load_user

  def auth
    if WL_CONFIG == nil
      render json: { error_code: 404, error_message: "No such route exists." } , status: 404
      return
    end

    # check against white list before answering request
    whitelist = WL_CONFIG['whitelist']
    valid_ip = false
    whitelist.each do |ip|
      valid_ip = true if request.remote_ip == ip
    end  

    if !valid_ip
      render json: { error_code: 404, error_message: "No such route exists." } , status: 404
      return
    end

    authenticated = false

    # check params present
    required_fields = %w(username password)
    return (render json: { error_code: 400, error_message: "Missing required params." }, status: 400 ) unless required_fields.all? { |k| params[k].present? }

    password = params[:password]
    username = params[:username]

    begin
      # basic user check
      hash = { :unique_id => username, :password => password }
      pseudonym_session = @domain_root_account.pseudonym_sessions.new(hash)
      
      # should never be nil but we check anyways
      if pseudonym_session.nil?
        return (render json: { error_code: 500, error_message: "Null pseudonym_session." }, status: 500)
      end
      authenticated = pseudonym_session.valid?
    
    rescue => e
      return (render json: { error_code: 500, error_message: e.message })
    end

    render json: { authenticated: authenticated ? "YES" : "NO" }
  end
end
