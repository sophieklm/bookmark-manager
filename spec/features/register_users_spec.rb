feature 'Registers users' do
  scenario 'a new user registers to the website' do
    signup
    expect(current_path).to eq '/links'
    expect(page).to have_content('Welcome to your bookmark manager, sophie@example.com!')
    expect{User.create}.to change{User.last.id}.by(1)
  end
  scenario 'user fills in password confirmation incorrectly' do
    expect { signup(password_confirmation: "error") }.to change(User, :count).by(0)
    expect(current_path).to eq '/signup'
    expect(page).to have_content("Password and confirmation do not match")
  end
end

def signup(password: "password", password_confirmation: "password")
  visit '/signup'
  fill_in 'email', with: 'sophie@example.com'
  fill_in 'password', with: password
  fill_in 'password_confirmation', with: password_confirmation
  click_button 'Submit'
end
