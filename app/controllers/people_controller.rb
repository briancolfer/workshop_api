class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :update, :destroy]

  # GET /people
  def index
    @people = Person.all
    json_response(@people)
  end

  # GET /people/:id
  def show
    json_response(@person)
  end

  # POST /people
  def create
    @person = Person.create!(person_params)
    json_response(@person, :created)
  end

  def update
    @person.update(person_params)
    head :no_content
  end

  def destroy
    @person.destroy
    head :no_content
  end

  private

  def person_params
    #allowed params
    params.permit(:first_name, :last_name, :birth_date)
  end

  def set_person
    @person = Person.find(params[:id])
  end

end
