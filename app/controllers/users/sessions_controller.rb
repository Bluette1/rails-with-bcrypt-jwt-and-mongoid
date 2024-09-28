class Users::SessionsController < ApplicationController
  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = generate_jwt(user)
      render json: { token: }, status: :created
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  def logout
    token = request.headers['Authorization']&.split(' ')&.last

    if token.present?
      # Blacklist the token
      RevokedToken.create(token:, revoked_at: Time.current)
    else
      render json: { error: 'Token not provided' }, status: :unprocessable_entity
    end
  end

  def generate_jwt(user)
    payload = { user_id: user.id, exp: 24.hours.from_now.to_i }
    JWT.encode(payload, Rails.application.credentials.jwt_secret_key)
  end

  def authenticate_user!
    token = request.headers['Authorization']&.split(' ')&.last
    return render json: { error: 'Token not provided' }, status: :unauthorized unless token

    # Check if the token is revoked
    return render json: { error: 'Token has been revoked' }, status: :unauthorized if RevokedToken.where(token:).exists?

    begin
      decoded = JWT.decode(token, Rails.application.credentials.jwt_secret_key, true, { algorithm: 'HS256' })
      @current_user = User.find(decoded[0]['user_id'])
    rescue JWT::DecodeError
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end
end
