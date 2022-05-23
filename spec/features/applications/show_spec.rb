require 'rails_helper'

RSpec.describe 'Applications Show Page' do
  it 'displays the applicants attributes' do
    application = Application.create!(name: 'Jenn', address: '123 Water Street, Denver, CO, 80111',
                                      description: 'I like animals!', status: 'In Progress')
    visit "/applications/#{application.id}"
    expect(page).to have_content('Jenn')
    expect(page).to have_content('123 Water Street, Denver, CO, 80111')
    expect(page).to have_content('I like animals!')
    expect(page).to have_content('In Progress')
  end

  it 'displays names of pets for application' do
    shelter = Shelter.create!(foster_program: true, name: 'Happy Dog', city: 'Denver', rank: 3)
    max = shelter.pets.create!(adoptable: true, age: 4, breed: 'Labrador', name: 'Max')
    sasha = shelter.pets.create!(adoptable: false, age: 2, breed: 'Pitsky', name: 'Sasha')
    application = Application.create!(name: 'Thomas', address: '12 Water Street, Denver, CO, 80111',
                                      description: 'Happy Home', status: 'In Progress')
    application2 = Application.create!(name: 'Sage', address: '42 Wind Avenue, Denver, CO, 80111',
                                       description: 'Happy home', status: 'In Progress')
    ApplicationPet.create!(pet: max, application: application)
    ApplicationPet.create!(pet: sasha, application: application)
    ApplicationPet.create!(pet: sasha, application: application2)
    visit "/applications/#{application.id}"
    expect(page).to have_content('Max')
    expect(page).to have_content('Sasha')
    click_link 'Max'
    expect(current_path).to eq("/pets/#{max.id}")
    visit "/applications/#{application.id}"
    click_link 'Sasha'
    expect(current_path).to eq("/pets/#{sasha.id}")
  end

  it 'has section to search for pet on in progress application' do
    application = Application.create!(name: 'Jenn', address: '123 Water Street, Denver, CO, 80111', description: 'I like animals!', status: 'In Progress')
    application2 = Application.create!(name: 'Sage', address: '42 Wind Avenue, Denver, CO, 80111', description: 'Happy home', status: 'Pending')
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 2, breed: 'labrador', name: 'Lobster', shelter_id: shelter.id)
    pet_4 = Pet.create(adoptable: true, age: 1, breed: 'chihuahua', name: 'Tiny', shelter_id: shelter.id)

    visit "/applications/#{application.id}"
    expect(page).to have_content("Add a Pet to this Application")
    
    fill_in 'search', with: pet_2.name 
    click_button("Find Pets")
    expect(current_path).to eq("/applications/#{application.id}")
    
    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(pet_2.age)
    expect(page).to have_content(pet_2.adoptable)
    expect(page).to have_content(pet_2.breed)
    expect(page).to have_content(pet_2.shelter_name)
    
    expect(page).to have_content(pet_3.name)
    expect(page).to have_content(pet_3.age)
    expect(page).to have_content(pet_3.adoptable)
    expect(page).to have_content(pet_3.breed)
    expect(page).to have_content(pet_3.shelter_name)
    
    expect(page).to have_content("Add a Pet to this Application")
    fill_in 'search', with: "Max" 
    click_button("Find Pets")
    expect(page).to_not have_content("Max")
    expect(page).to_not have_content(pet_2.name)
    expect(page).to_not have_content(pet_3.name)
    expect(page).to_not have_content(pet_4.name)
    
    expect(current_path).to eq("/applications/#{application.id}")
  
    visit "/applications/#{application2.id}"
    expect(page).to_not have_content("Add a Pet to this Application")
  end

  it 'can add pet to application from list of pets that appears after a namee is searched' do
    application = Application.create!(name: 'Jenn', address: '123 Water Street, Denver, CO, 80111', description: 'I like animals!', status: 'In Progress')
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 2, breed: 'labrador', name: 'Lobster', shelter_id: shelter.id)
    pet_4 = Pet.create(adoptable: true, age: 1, breed: 'chihuahua', name: 'Tiny', shelter_id: shelter.id)

    visit "/applications/#{application.id}"
    expect(page).to_not have_content("Lobster")
    fill_in 'search', with: pet_2.name 
    click_button("Find Pets")
    expect(current_path).to eq("/applications/#{application.id}")
    
    click_button("Adopt this Pet")
    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_content("Lobster")
  end
end
