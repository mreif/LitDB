class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :ldap_authenticatable, #:recoverable,
    :trackable#, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :login, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
end
