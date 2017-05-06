def signin(email: 'sophie@example.com', password: "password", password_confirmation: "password")
  visit '/sessions/new'
  fill_in 'email', with: email
  fill_in 'password', with: password
  click_button 'Submit'
end

def signout
  click_button 'Sign Out'
end
