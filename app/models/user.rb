require 'bcrypt'
require 'securerandom'

class User
  include DataMapper::Resource
  include BCrypt

  property :id,       Serial
  property :email,    String, required: true
  property :password_hash, Text
  property :password_token, String, length: 60
  property :password_token_time, Time

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
    self.password_token_time = Time.now
    self.save
  end

  def self.find_by_valid_token(token)
    user = first(password_token: token)
    if (user && user.password_token_time + (60*60) > Time.now)
      user
    end
  end

end
