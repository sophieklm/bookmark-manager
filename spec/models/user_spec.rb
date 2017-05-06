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
end
