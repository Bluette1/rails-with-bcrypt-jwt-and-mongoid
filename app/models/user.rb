# class User
#   include Mongoid::Document
#   # Include default devise modules. Others available are:
#   # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
#   devise :database_authenticatable, :registerable,
#          :recoverable, :rememberable, :validatable,
#          :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

#         #  def generate_jwt
#         #    JWT.encode({ id: id, exp: 24.hours.from_now.to_i }, Rails.application.credentials.jwt_secret_key)
#         #  end
#         # def generate_jwt
#         #   payload = { id: self.id, exp: 24.hours.from_now.to_i, jti: SecureRandom.uuid }
#         #   JWT.encode(payload, Rails.application.credentials.jwt_secret_key)
#         # end

#         def generate_jwt
#           payload = {
#             id: self.id,
#             exp: 24.hours.from_now.to_i,
#             jti: SecureRandom.uuid,
#             scp: ['default'] # Or whatever scopes you want to set
#           }
#           JWT.encode(payload, Rails.application.credentials.jwt_secret_key)
#         end
        
#   ## Database authenticatable
#   field :email,              type: String, default: ""
#   field :encrypted_password, type: String, default: ""

#   ## Recoverable
#   field :reset_password_token,   type: String
#   field :reset_password_sent_at, type: Time

#   ## Rememberable
#   field :remember_created_at, type: Time

#   ## Trackable
#   # field :sign_in_count,      type: Integer, default: 0
#   # field :current_sign_in_at, type: Time
#   # field :last_sign_in_at,    type: Time
#   # field :current_sign_in_ip, type: String
#   # field :last_sign_in_ip,    type: String

#   ## Confirmable
#   # field :confirmation_token,   type: String
#   # field :confirmed_at,         type: Time
#   # field :confirmation_sent_at, type: Time
#   # field :unconfirmed_email,    type: String # Only if using reconfirmable

#   ## Lockable
#   # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
#   # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
#   # field :locked_at,       type: Time
#   include Mongoid::Timestamps
# end


class User
  include Mongoid::Document
  include ActiveModel::SecurePassword

  field :email, type: String
  field :password_digest, type: String

  has_secure_password
end
