require 'rails_helper'

RSpec.describe Course, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
  end
  describe "User" do
    it "Should be created with valid attributes" do
      count = 0
      course = FactoryBot.build(:course)
      course.author = @user
      course.save
      expect(course.valid?).to eq(true)
      expect(count+1).to eq(Course.count)
    end
  end
end
