require 'rails_helper'

RSpec.describe 'admin shelter index page' do

    it 'lists shelters in the system in reverse alphabetical order' do
        shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
        shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    
        visit '/admin/shelters'

        within('#shelter-0') do
            expect(page).to have_content("RGV animal shelter")
            expect(page).to_not have_content("Fancy pets of Colorado")
            expect(page).to_not have_content("Aurora shelter")
        end
        within('#shelter-1') do
            expect(page).to have_content("Fancy pets of Colorado")
            expect(page).to_not have_content("RGV animal shelter")
            expect(page).to_not have_content("Aurora shelter")
        end
        within('#shelter-2') do
            expect(page).to have_content("Aurora shelter")
            expect(page).to_not have_content("Fancy pets of Colorado")
            expect(page).to_not have_content("RGV animal shelter")
        end
    end
end