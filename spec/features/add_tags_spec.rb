feature 'Creating tags' do

  scenario 'Can add tags to a link' do
    visit '/links/new'
    fill_in :url, with:  "http://makersacademy.com"
    fill_in :title, with: "Makers Academy"
    fill_in :tags, with: "Ruby"
    click_button 'Add Link'
    within 'ul#links' do
      expect(page).to have_content 'Ruby'
    end
  end
end
