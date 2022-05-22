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
    Application.create(name: params[:name])
  end
end
