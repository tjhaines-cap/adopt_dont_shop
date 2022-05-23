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
end
