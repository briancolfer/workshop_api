require 'rails_helper'

RSpec.describe Workshop, type: :model do
  before(:all) do
    @workshop1 = create(:workshop)
    @invalid_workshop1 = build(:workshop, workshop_name: '')
    @invalid_workshop2 = build(:workshop, workshop_name: '1234')
    @invalid_workshop4 = build(:workshop, description: '123456789')
  end
  it "is valid with workshop_name and description and start_date and end_date" do
    expect(@workshop1).to be_valid
  end
  it "is invalid without workshop_name" do
    expect(@invalid_workshop1).to_not be_valid
  end

  it "is invalid with workshop_name shorter than 6 letters" do
    expect(@invalid_workshop2).to_not be_valid
  end
  it "is invalid with duplicate workshop_name" do
    @invalid_workshop3a = create(:workshop, workshop_name: "Workshop Name Good")
    @invalid_workshop3b = @invalid_workshop3a.dup
    expect(@invalid_workshop3b).to_not be_valid
  end
  it "is invalid if the description is shorter than 10 letters" do
    expect(@invalid_workshop4).to_not be_valid
  end

  it "is invalid if the start_date and end_date are missing" do
    @workshop_missing_start_date = build(:workshop, start_date: "", end_date:"")
    expect(@workshop_missing_start_date).to_not be_valid
  end

  it "is invalid if the start_date is after the end_date" do
    @workshop_end_date_before_start_date = build(:workshop, :start_date_after_end_date)
    expect(@workshop_end_date_before_start_date).to_not be_valid
  end

end