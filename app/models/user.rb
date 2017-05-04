require 'bcrypt'

class User
  include DataMapper::Resource
  include BCrypt

  property :id,       Serial
  property :email,    String
  property :password_hash, Text

  attr_reader :password
  attr_accessor :password_confirmation

  validates_confirmation_of :password

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end
