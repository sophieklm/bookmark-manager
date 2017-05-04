require 'bcrypt'

class User
  include DataMapper::Resource
  include BCrypt

  property :id,       Serial
  property :email,    String
  property :password_hash, Text

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end
