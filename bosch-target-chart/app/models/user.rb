class User < ApplicationRecord
  ##### Include default devise modules. (See Docs: https://github.com/plataformatec/devise)
  ##### Options:
  # :database_authenticatable - hashes and stores a password in the database to validate the authenticity of a user while signing in. The authentication can be done both through POST requests or HTTP Basic Authentication.
  # :omniauthable             - adds OmniAuth (https://github.com/omniauth/omniauth) support.
  # :confirmable              - sends emails with confirmation instructions and verifies whether an account is already confirmed during sign in.
  # :recoverable              - resets the user password and sends reset instructions.
  # :registerable             - handles signing up users through a registration process, also allowing them to edit and destroy their account.
  # :rememberable             - manages generating and clearing a token for remembering the user from a saved cookie.
  # :trackable                - tracks sign in count, timestamps and IP address.
  # :timeoutable              - expires sessions that have not been active in a specified period of time.
  # :validatable              - provides validations of email and password. It's optional and can be customized, so you're able to define your own validations.
  # :lockable                 - locks an account after a specified number of failed sign-in attempts. Can unlock via email or after a specified time period.
  devise :database_authenticatable, :confirmable, :recoverable,
          :registerable, :trackable, :timeoutable, :lockable,
          :validatable, password_length: Devise.password_length

  validates_presence_of :first_name, :last_name
  
  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: Devise::email_regexp }

  validates :password,
            confirmation: true,
            length: { within: Devise::password_length },
            on: :create

  validate :email_domain_valid?

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  private

  def email_domain_valid?
    if (Rails.env != 'test' && self.email && ENV['valid_domains'].present? && ENV['valid_domains'].split(',').none?{ |domain| self.email.ends_with?(domain.strip) })
      errors.add(:email, :invalid_domain)
    end
  end
end
