# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
shelter1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter1.id)
pet_2 = Pet.create(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter1.id)
pet_3 = Pet.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter1.id)
shelter2 = Shelter.create!(foster_program: true, name: 'Happy Dog', city: 'Denver', rank: 3)
max = shelter2.pets.create!(adoptable: true, age: 4, breed: 'Labrador', name: 'Max')
sasha = shelter2.pets.create!(adoptable: false, age: 2, breed: 'Pitsky', name: 'Sasha')
application = Application.create!(name: 'Thomas', address: '12 Water Street, Denver, CO, 80111',
                                  description: 'Happy Home', status: 'In Progress')
application2 = Application.create!(name: 'Sage', address: '42 Wind Avenue, Denver, CO, 80111',
                                   description: 'Happy home', status: 'In Progress')
ApplicationPet.create!(pet: max, application: application)
ApplicationPet.create!(pet: sasha, application: application)
ApplicationPet.create!(pet: sasha, application: application2)
