require "rails_helper"

RSpec.describe 'Applications New Page' do
  it 'has form for new application' do
    visit "/applications/new"

    fill_in 'Name', with: "Sage"
    fill_in 'Street Address', with: "42 Wind Avenue"
    fill_in 'City', with: "Denver"
    fill_in 'State', with: "CO"
    fill_in 'Zip Code', with: "80111"
    fill_in 'Why you would make a good home?', with: 'Lots of love!'
    click_on("Submit")

    expect(page).to have_content('Sage')
    expect(page).to have_content('42 Wind Avenue, Denver, CO, 80111')
    expect(page).to have_content('In Progress')
    expect(page).to have_content('Lots of love!')
  end
end
