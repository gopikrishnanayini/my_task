class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable ,
         :omniauthable, :omniauth_providers => [:facebook]
  validates :email,
             :presence =>true,
             :uniqueness => true,
             :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
             :message => "This field is required." }
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token[0,20]
      if ["facebook"].include?(auth.provider)
        user.save(:validate => false)
      else
        user.email = auth.info.email
        user.save
      end
    end
  end
end
