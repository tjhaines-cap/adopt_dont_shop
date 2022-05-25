class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets_approved = []
    @pets_approved << params[:pet_id] if params[:pet_id]
    @pets_rejected = []
    @pets_rejected << params[:pet_id] if params[:pet_id]
  end
end
