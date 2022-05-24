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

  def new
  end

  def create
    params[:address] = "#{params[:street_address]}, #{params[:city]}, #{params[:state]}, #{params[:zip_code]}"
    app = Application.create!(application_params)
    redirect_to "/applications/#{app.id}"
  end

  private
  def application_params
    params.permit(:name, :address, :description, :status)
  end
end
