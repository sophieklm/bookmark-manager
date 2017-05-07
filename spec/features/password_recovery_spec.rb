feature "Resetting Password" do
  before do
    signup
    Capybara.reset!
  end
  let(:user) { User.first }
  scenario "user can see a password reset link" do
    visit '/sessions/new'
    click_link "Forgotten Password?"
    expect(page).to have_content("Please enter your email address")
  end
  scenario "user is asked to check email" do
    recover_password
    expect(page).to have_content "Thanks, please check your inbox."
  end
  scenario "reset token only lasts one hour" do
    recover_password
    Timecop.travel(60 * 60 * 60) do
      visit("/users/reset_password?token=#{user.password_token}")
      expect(page).to have_content "This token is no longer valid"
    end
  end
  scenario "user is asked for new password when token is valid" do
    recover_password
    visit("/users/reset_password?token=#{user.password_token}")
    expect(page).to have_content("Please enter your new password")
  end
  scenario "user can enter a new password when token valid" do
    recover_password
    visit("/users/reset_password?token=#{user.password_token}")
    fill_in :password, with: "password"
    fill_in :password_confirmation, with: "password"
    click_button "Submit"
    expect(page).to have_content("Sign In")
  end

  scenario "user can sign in after password reset" do
    recover_password
    visit("/users/reset_password?token=#{user.password_token}")
    fill_in :password, with: "newpassword"
    fill_in :password_confirmation, with: "newpassword"
    click_button "Submit"
    signin(email: user.email, password: "newpassword")
    expect(page).to have_content "Welcome to your bookmark manager, #{user.email}"
  end
end
