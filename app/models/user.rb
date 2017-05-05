require 'bcrypt'

class User
  include DataMapper::Resource
  include BCrypt

  property :id,       Serial
  property :email,    String, required: true
  property :password_hash, Text

  attr_reader :password
  attr_accessor :password_confirmation

  validates_confirmation_of :password, :message => "Password and confirmation do not match"
  validates_presence_of :email
  validates_format_of :email, as: :email_address
  validates_uniqueness_of :email, :message => "Email is already registered"

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end
