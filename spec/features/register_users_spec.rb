feature 'Registers users' do
  scenario 'a new user registers to the website' do
    expect{ signup }.to change(User, :count).by(1)
    expect(current_path).to eq '/links'
    expect(page).to have_content('Welcome to your bookmark manager, sophie@example.com!')
  end
  scenario 'user fills in password confirmation incorrectly' do
    expect { signup(password_confirmation: "error") }.to change(User, :count).by(0)
    expect(current_path).to eq '/signup'
    expect(page).to have_content("Password and confirmation do not match")
  end
  scenario 'user cannot sign up without email' do
    expect { signup(email: "") }.to change(User, :count).by(0)
    expect(current_path).to eq '/signup'
  end
  scenario 'user cannot sign up with invalid email' do
    expect { signup(email: "invalid@email") }.to change(User, :count).by(0)
    expect(current_path).to eq '/signup'
  end
end

def signup(email: 'sophie@example.com', password: "password", password_confirmation: "password")
  visit '/signup'
  fill_in 'email', with: email
  fill_in 'password', with: password
  fill_in 'password_confirmation', with: password_confirmation
  click_button 'Submit'
end
