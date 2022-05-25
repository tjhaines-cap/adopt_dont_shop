require 'rails_helper'

RSpec.describe 'Admin Applications Show Page' do
  it 'displays each pet with a button to approve' do
    shelter1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter1.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter1.id)
    pet_3 = Pet.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter1.id)
    shelter2 = Shelter.create!(foster_program: true, name: 'Happy Dog', city: 'Denver', rank: 3)
    max = shelter2.pets.create!(adoptable: true, age: 4, breed: 'Labrador', name: 'Max')
    sasha = shelter2.pets.create!(adoptable: false, age: 2, breed: 'Pitsky', name: 'Sasha')
    application = Application.create!(name: 'Thomas', address: '12 Water Street, Denver, CO, 80111',
                                      description: 'Happy Home', status: 'In Progress')

    ApplicationPet.create!(pet: max, application: application)
    ApplicationPet.create!(pet: sasha, application: application)

    visit "/admin/applications/#{application.id}"
    within('#pet-0') do
      expect(page).to have_content('Max')
      expect(page).to have_button('Approve')
      expect(page).to_not have_content('Sasha')
      click_button 'Approve'
      expect(current_path).to eq("/admin/applications/#{application.id}")
      expect(page).to_not have_button('Approve')
      expect(page).to have_content('Approved')
    end

    within('#pet-1') do
      expect(page).to have_content('Sasha')
      expect(page).to have_button('Approve')
      expect(page).to_not have_content('Max')
      click_button 'Approve'
      expect(current_path).to eq("/admin/applications/#{application.id}")
      expect(page).to_not have_button('Approve')
      expect(page).to have_content('Approved')
    end
  end

  it 'displays each pet with a button to reject' do
    shelter1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter1.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter1.id)
    pet_3 = Pet.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter1.id)
    shelter2 = Shelter.create!(foster_program: true, name: 'Happy Dog', city: 'Denver', rank: 3)
    max = shelter2.pets.create!(adoptable: true, age: 4, breed: 'Labrador', name: 'Max')
    sasha = shelter2.pets.create!(adoptable: false, age: 2, breed: 'Pitsky', name: 'Sasha')
    application = Application.create!(name: 'Thomas', address: '12 Water Street, Denver, CO, 80111',
                                      description: 'Happy Home', status: 'In Progress')

    ApplicationPet.create!(pet: max, application: application)
    ApplicationPet.create!(pet: sasha, application: application)

    visit "/admin/applications/#{application.id}"
    within('#pet-0') do
      expect(page).to have_content('Max')
      expect(page).to have_button('Reject')
      expect(page).to_not have_content('Sasha')
      click_button 'Reject'
      expect(current_path).to eq("/admin/applications/#{application.id}")
      expect(page).to_not have_button('Reject')
      expect(page).to have_content('Rejected')
    end

    within('#pet-1') do
      expect(page).to have_content('Sasha')
      expect(page).to have_button('Reject')
      expect(page).to_not have_content('Max')
      click_button 'Reject'
      expect(current_path).to eq("/admin/applications/#{application.id}")
      expect(page).to_not have_button('Reject')
      expect(page).to have_content('Rejected')
    end
  end
end
