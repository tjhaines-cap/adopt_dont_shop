class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:application_id])
  end

  def new
  end

  def create
    Application.create(artist_params)
    redirect_to '/applications'
  end

  private
  def artist_params
    params.permit(:name, :address, :description, :status)
  end
end
