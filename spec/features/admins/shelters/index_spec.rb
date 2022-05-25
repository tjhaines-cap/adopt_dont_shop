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

    it 'displays section listing shelters with pending applications' do
        @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
        @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

        @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
        @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
        @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
        @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
        @pet_5 = @shelter_2.pets.create!(name: 'Max', breed: 'Labrador', age: 4, adoptable: true)
        
        @application = Application.create!(name: 'Thomas', address: '12 Water Street, Denver, CO, 80111',
                                            description: 'Happy Home', status: 'In Progress')
        @application2 = Application.create!(name: 'Sage', address: '42 Wind Avenue, Denver, CO, 80111',
                                            description: 'Happy home', status: 'In Progress')
        
        ApplicationPet.create!(pet: @pet_1, application: @application)
        ApplicationPet.create!(pet: @pet_3, application: @application2)
  
        visit '/admin/shelters'

        expect(page).to have_content("Shelter's with Pending Applications")
        within('#shelter_pending-0') do
            expect(page).to have_content(@shelter1.name)
            expect(page).to_not have_content(@shelter2.name)
            expect(page).to_not have_content(@shelter3.name)
        end
        within('#shelter_pending-1') do
            expect(page).to have_content(@shelter3.name)
            expect(page).to_not have_content(@shelter1.name)
            expect(page).to_not have_content(@shelter2.name)
        end
        within('#shelter_pending-2') do
            expect(page).to_not have_content(@shelter3.name)
            expect(page).to_not have_content(@shelter1.name)
            expect(page).to_not have_content(@shelter2.name)
        end
        
    end
end