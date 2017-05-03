feature 'Viewing Tags' do
  scenario "visiting tag page and viewing links by tag" do
    visit '/links/new'
    fill_in :url, with:  "http://makersacademy.com"
    fill_in :title, with: "Makers Academy"
    fill_in :tags, with: "ruby"
    click_button "Add Link"
    visit '/tag/ruby'
    expect(page).to have_content "Makers Academy"
  end
end
