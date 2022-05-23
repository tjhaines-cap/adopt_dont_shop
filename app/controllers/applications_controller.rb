class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end
  
  def show
    if params[:search].present?
      @pets = Pet.search(params[:search])
      @application = Application.find(params[:application_id])
    else
      @application = Application.find(params[:application_id])
    end
  end

  def update
    # binding.pry
    selected_pet = Pet.find(params[:pet_id])
    application = Application.find(params[:application_id])
    ApplicationPet.create!(pet: selected_pet, application: application)
    redirect_to "/applications/#{params[:application_id]}"
  end
end
