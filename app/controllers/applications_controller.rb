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
    selected_pet = Pet.find(params[:pet_id])
    application = Application.find(params[:application_id])
    ApplicationPet.create!(pet: selected_pet, application: application)
    redirect_to "/applications/#{params[:application_id]}"
  end

  def new
  end

  def create
    params[:address] = "#{params[:street_address]}, #{params[:city]}, #{params[:state]}, #{params[:zip_code]}"
    if params[:name] == "" || params[:street_address] == "" || params[:city] == "" || params[:state] == "" || params[:zip_code] == "" || params[:description] == ""
      redirect_to "/applications/new"
      return
    end
    app = Application.create!(application_params)
    redirect_to "/applications/#{app.id}"
  end

  private
  def application_params
    params.permit(:name, :address, :description, :status)
  end
end
