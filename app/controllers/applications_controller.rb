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
    app = Application.new(application_params)
    if app.save
      redirect_to "/applications/#{app.id}"
      return
    else
      flash[:notice] = "Error submitting request, please fill in all fields"
      render :new
    end
  end

  private
  def application_params
    params.permit(:name, :address, :description, :status)
  end
end
