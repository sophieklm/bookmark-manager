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
end
