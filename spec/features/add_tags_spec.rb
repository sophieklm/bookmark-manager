feature 'Creating tags' do

  scenario 'Can add tags to a link' do
    visit '/links/new'
    fill_in :url, with:  "http://makersacademy.com"
    fill_in :title, with: "Makers Academy"
    fill_in :tags, with: "ruby"
    click_button 'Add Link'
    within 'ul#links' do
      expect(page).to have_content 'ruby'
    end
  end

  scenario 'Can add multiple tags to a link' do
    visit '/links/new'
    fill_in :url, with:  "http://makersacademy.com"
    fill_in :title, with: "Makers Academy"
    fill_in :tags, with: "ruby code"
    click_button 'Add Link'
    within 'ul#links' do
      expect(Link.first.tags.map(&:tag)).to include('ruby', 'code')
    end
  end
end
