def signin(email: 'sophie@example.com', password: "password", password_confirmation: "password")
  visit '/sessions/new'
  fill_in 'email', with: email
  fill_in 'password', with: password
  click_button 'Submit'
end

def signout
  click_button 'Sign Out'
end

def signup(email: 'sophie@example.com', password: "password", password_confirmation: "password")
  visit '/users/new'
  fill_in 'email', with: email
  fill_in 'password', with: password
  fill_in 'password_confirmation', with: password_confirmation
  click_button 'Submit'
end

def recover_password
  visit '/users/recover'
  fill_in :email, with: "sophie@example.com"
  click_button "Submit"
end
