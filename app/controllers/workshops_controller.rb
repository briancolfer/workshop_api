class WorkshopsController < ApplicationController
  before_action :set_workshop, only: [:show, :update, :destroy]

  def index
    @workshops = Workshop.all
    json_response(@workshops)
  end

  def show
    json_response(@workshop)
  end

  def create
    @workshop = Workshop.create!(workshop_params)
    json_response(@workshop, :created)
  end

  def update
    @workshop.update(workshop_params)
    head :no_content
  end

  def destroy
    @person.destroy
    head :no_content
  end

  private

  def workshop_params
    params.permit(:workshop_name, :description, :start_date, :end_date)
  end

  def set_workshop
    @workshop = Workshop.find(params[:id])
  end
end
