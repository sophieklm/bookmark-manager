require 'bcrypt'
require 'securerandom'

class User
  include DataMapper::Resource
  include BCrypt

  property :id,       Serial
  property :email,    String, required: true
  property :password_hash, Text
  property :password_token, String, length: 60

  attr_reader :password
  attr_accessor :password_confirmation

  validates_confirmation_of :password, :message => "Password and confirmation do not match"
  validates_presence_of :email
  validates_format_of :email, as: :email_address
  validates_uniqueness_of :email, :message => "Email is already registered"

  def password=(password)
    @password = Password.create(password)
    self.password_hash = @password
  end

  def self.authenticate(email, password)
    user = first(email: email)
    if user && Password.new(user.password_hash) == password
      user
    else
      nil
    end
  end

  def generate_token
    self.password_token = SecureRandom.hex
    self.save
  end

end
