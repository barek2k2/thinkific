require 'rails_helper'

RSpec.describe Chapter, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
    @course = FactoryBot.create(:course, author: @user)
  end
  describe "Chapter" do
    it "Should be created with valid attributes" do
      count = 0
      @chapter = FactoryBot.build(:chapter, course: @course)
      expect(@chapter.valid?).to eq(true)
      @chapter.save
      expect(count+1).to eq(Chapter.count)
    end
  end

  describe "#import_contents_from" do
    it "should import multimedia contents from the csv file" do
      chapter = FactoryBot.create(:chapter, course: @course)
      csv_file = File.open("#{Rails.root}/spec/files/bulk_multimedia_contents.csv")
      chapter.import_contents_from(csv_file)
      expect(chapter.contents.count).to eq(2)
      expect(chapter.contents.collect{|c| c.files.size }.sum).to eq(2)
    end
  end
end
