require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = FactoryBot.build(:user)
  end
  describe "User" do
    it "Should be created with valid attributes" do
      count = 0
      @user.save
      expect(@user.valid?).to eq(true)
      expect(count+1).to eq(User.count)
    end
  end
end