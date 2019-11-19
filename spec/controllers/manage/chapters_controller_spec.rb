require 'rails_helper'

RSpec.describe Manage::ChaptersController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @course = FactoryBot.create(:course, author: @user)
    sign_in @user
  end

  describe "GET 'index'" do
    it "should be successful" do
      get :index, params: {course_id: @course.id}
      expect(assigns(:chapters)).not_to be_nil
      expect(response).to render_template("index")
      expect(response).to be_successful
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get :new, params: {course_id: @course.id}
      expect(assigns(:chapter)).to be_new_record
      expect(response).to render_template("new")
      expect(response).to be_successful
    end
  end

  describe "POST 'create'" do
    it "should be successful" do
      @chapter = FactoryBot.build(:chapter)
      params = FactoryBot.attributes_for :chapter
      post :create, params: {course_id: @course.id, chapter: params}
      expect(response).to redirect_to(manage_course_chapters_url(@course))
      expect(flash[:notice]).to eq("Your chapter was created successfully.")
    end
  end

  describe "GET 'edit'" do
    before do
      @chapter = FactoryBot.create(:chapter, course: @course)
    end
    it "should be successful" do
      get :edit, params: {course_id: @course.id, id: @chapter.id}
      expect(assigns(:chapter)).not_to be_new_record
      expect(response).to render_template("edit")
      expect(response).to be_successful
    end
  end

  describe "PUT 'update'" do
    before do
      @chapter = FactoryBot.create(:chapter, course: @course)
    end
    it "should be successful" do
      put :update, params: {course_id: @course.id, id: @chapter.id, chapter: {title: "test chapter"}}
      @chapter.reload
      expect(response).to redirect_to(manage_course_chapters_url(@course))
      expect(@chapter.title).to eq("test chapter")
      expect(flash[:notice]).to eq("Your chapter was updated successfully.")
    end
  end

  describe "GET 'bulk_import'" do
    before do
      @chapter = FactoryBot.create(:chapter, course: @course)
    end
    it "should be successful" do
      get :bulk_import, params: {course_id: @course.id, id: @chapter.id}
      expect(response).to render_template("bulk_import")
      expect(response).to be_successful
    end
  end

  describe "POST 'bulk_import'" do
    before do
      @chapter = FactoryBot.create(:chapter, course: @course)
    end
    context "while no csv is uploaded" do
      it "should not be successful" do
        post :bulk_import, params: {course_id: @course.id, id: @chapter.id}
        expect(response).to redirect_to(manage_course_chapters_url(@course))
        expect(flash[:alert]).to eq("Please choose valid csv to import contents.")
      end
    end
    context "while valid csv is uploaded" do
      let(:file) { Rack::Test::UploadedFile.new "#{Rails.root}/spec/files/bulk_multimedia_contents.csv", 'text/csv' }
      it "should be successful" do
        post :bulk_import, params: {course_id: @course.id, id: @chapter.id, bulk_import: {
          csv: file
        }}
        @chapter.reload
        expect(response).to redirect_to(manage_course_chapter_contents_url(@course, @chapter))
        expect(@chapter.contents.collect{|c| c.files.count }.sum).to eq(2)
        expect(flash[:alert]).to be_nil
        expect(flash[:notice]).to eq("Multimedia content(s) were imported successfully.")
      end
    end
  end

end
