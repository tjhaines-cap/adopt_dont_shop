class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets_rejected = []
    @pets_approved = []
    if params[:approved] == 'true'
      @pets_approved << params[:pet_id] if params[:pet_id]
    elsif params[:approved] == 'false'
      @pets_rejected << params[:pet_id] if params[:pet_id]
    end
  end
end
