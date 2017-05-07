describe User do
  let!(:user) do
    User.create(email: 'sophie@example.com', password: "password", password_confirmation: "password")
  end
  it 'authenticates when given registered user details' do
    authenticate_user = User.authenticate(user.email, "password")
    expect(authenticate_user).to eq user
  end
  it 'does not authenticate user when given wrong password' do
    authenticate_user = User.authenticate(user.email, "error")
    expect(authenticate_user).to be_nil
  end
  it 'saves a password recovery token when generated' do
    expect{user.generate_token}.to change{user.password_token}
  end
  it 'saves password recovery token time' do
    Timecop.freeze do
      user.generate_token
      expect(user.password_token_time).to eq Time.now
    end
  end
  it 'finds user with valid token' do
    user.generate_token
    expect(User.find_by_valid_token(user.password_token)).to eq user
  end
  it 'does not return user when token invalid' do
    user.generate_token
    Timecop.travel(60 * 60 * 60) do
      expect(User.find_by_valid_token(user.password_token)).to eq nil
    end
  end
end
