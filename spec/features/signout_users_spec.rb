feature "Signing out" do
  let!(:user) do
    User.create(email: 'sophie@example.com', password: "password", password_confirmation: "password")
  end
  scenario "user can sign out" do
    signin
    signout
    expect(page).to have_content('Goodbye!')
  end
end
