require 'rails_helper'

RSpec.describe Person, type: :model do

  before(:all) do
    @person1 = create(:person)
    @invalid_person1 = build(:person, first_name: '', last_name: '')
    @invalid_person2 = build(:person, birth_date: Date.tomorrow )
  end

  it "is a valid fist_name, last_name and birth date between 18 and 65 years ago" do
    expect(@person1).to be_valid
  end

  it "is invalid with no first_name and last_name" do
    expect(@invalid_person1).to_not be_valid
  end

  it "is invalid with birth date tomorrow" do
    expect(@invalid_person2).to_not be_valid
  end

end
