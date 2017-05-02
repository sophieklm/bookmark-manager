feature 'creating links' do
  scenario 'add a link to bookmark list' do
    visit('/links/new')
    fill_in :url, with:  "http://makersacademy.com"
    fill_in :title, with: "Makers Academy"
    click_button "Add Link"
    expect(current_path).to eq "/links"
    within "ul#links" do
      expect(page).to have_content("Makers Academy")
    end
  end
end
