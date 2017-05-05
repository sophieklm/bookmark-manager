feature "Signing in" do
  let!(:user) do
    User.create(email: 'sophie@example.com', password: "password", password_confirmation: "password")
  end
  scenario "user can sign in" do
    signin
    expect(current_path).to eq '/links'
    expect(page).to have_content('Welcome to your bookmark manager, sophie@example.com! ')
  end
  scenario "user signs in with wrong email" do
    signin(password: 'wrong')
    expect(current_path).to eq '/sessions/new'
  end
end
