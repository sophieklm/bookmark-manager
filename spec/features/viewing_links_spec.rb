feature 'viewing links' do
  scenario 'see a list of pages I have bookmarked' do
    Link.create(url: "http://makersacademy.com", title: "Makers Academy")
    visit '/links'
    expect(page.status_code).to eq 200
    within "ul#links" do
      expect(page).to have_content("Makers Academy")
    end
  end
end
