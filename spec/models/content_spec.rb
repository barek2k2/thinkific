require 'rails_helper'

RSpec.describe Content, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
    @course = FactoryBot.create(:course, author: @user)
    @chapter = FactoryBot.create(:chapter, course: @course)
  end
  describe "Content" do
    context "while no file is attached" do
      it "Should be created with valid attributes" do
        count = 0
        content = FactoryBot.build(:content, chapter: @chapter)
        content.save
        expect(content.valid?).to eq(true)
        expect(count+1).to eq(Content.count)
      end
    end

    context "while a file is attached" do
      it "Should be created with valid attributes" do
        content = FactoryBot.build(:content, chapter: @chapter, content_type: 'pdf')
        content.files.attach(io: open("#{Rails.root}/spec/files/file-sample_150kB.pdf"), filename: 'file-sample_150kB.pdf')
        content.save
        expect(content.valid?).to eq(true)
        expect(content.files.count).to eq(1)
      end
    end

    context "while content type and uploaded file are different" do
      it "Should not be created" do
        content = FactoryBot.build(:content, chapter: @chapter, content_type: 'video')
        content.files.attach(io: open("#{Rails.root}/spec/files/file-sample_150kB.pdf"), filename: 'file-sample_150kB.pdf')
        content.save
        expect(content.valid?).to eq(false)
        expect(content.errors.full_messages.include?('Files has an invalid content type')).to eq(true)
      end
    end
  end
end
