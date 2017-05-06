feature "Resetting Password" do
  scenario "user can see a password reset link" do
    visit '/sessions/new'
    click_link "Forgotten Password?"
    expect(page).to have_content("Please enter your email address")
  end
  scenario "user is asked to check email" do
    visit '/users/recover'
    fill_in :email, with: "sophie@example.com"
    click_button "Submit"
    expect(page).to have_content "Thanks, please check your inbox."
  end

end
