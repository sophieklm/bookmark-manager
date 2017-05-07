feature "Resetting Password" do
  before do
    signup
    Capybara.reset!
    allow(SendRecoverLink).to receive(:call)
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
    set_password(password: "newpassword", password_confirmation: "newpassword")
    expect(page).to have_content("Sign In")
  end

  scenario "user can sign in after password reset" do
    recover_password
    set_password(password: "newpassword", password_confirmation: "newpassword")
    signin(email: user.email, password: "newpassword")
    expect(page).to have_content "Welcome to your bookmark manager, #{user.email}"
  end

  scenario "checks password confirmation matches" do
    recover_password
    set_password(password: "password", password_confirmation: "otherpassword")
    expect(page).to have_content("Password and confirmation do not match")
  end

  scenario "it resets token when password updated" do
    recover_password
    set_password(password: "newpassword", password_confirmation: "newpassword")
    visit("/users/reset_password?token=#{user.password_token}")
    expect(page).to have_content("This token is no longer valid")
  end

  scenario "it calls SendRecoverLink service to send the link" do
    expect(SendRecoverLink).to receive(:call).with(user)
    recover_password
  end

end
