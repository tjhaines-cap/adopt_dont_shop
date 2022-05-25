class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets_approved = []
    @pets_approved << params[:pet_id] if params[:pet_id]
  end

  def approve
    redirect_to "/admin/applications/#{params[:id]}"
  end
end
