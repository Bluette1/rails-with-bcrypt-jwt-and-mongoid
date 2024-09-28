class RevokedToken
  include Mongoid::Document
  
  field :token, type: String
  field :revoked_at, type: Time
end