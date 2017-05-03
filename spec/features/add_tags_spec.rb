feature 'Creating tags' do

  scenario 'Can add tags to a link' do
    visit '/links/new'
    fill_in :url, with:  "http://makersacademy.com"
    fill_in :title, with: "Makers Academy"
    fill_in :tags, with: 'search_engine'
    click_button 'Add Link'
    within 'ul#links' do
      expect(page).to have_content 'search_engine'
    end
  end
end
