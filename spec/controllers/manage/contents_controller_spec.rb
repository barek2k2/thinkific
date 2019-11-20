require 'rails_helper'

RSpec.describe Manage::ContentsController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @course = FactoryBot.create(:course, author: @user)
    @chapter = FactoryBot.create(:chapter, course: @course)
    sign_in @user
  end

  describe "GET 'index'" do
    it "should be successful" do
      get :index, params: {course_id: @course.id, chapter_id: @chapter.id}
      expect(assigns(:contents)).not_to be_nil
      expect(response).to render_template("index")
      expect(response).to be_successful
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get :new, params: {course_id: @course.id, chapter_id: @chapter.id}
      expect(assigns(:content)).to be_new_record
      expect(response).to render_template("new")
      expect(response).to be_successful
    end
  end

  describe "POST 'create'" do
    it "should be successful" do
      @content = FactoryBot.build(:content)
      params = FactoryBot.attributes_for :content
      post :create, params: {course_id: @course.id, chapter_id: @chapter.id, content: params}

      last_created_content = Content.last
      expect(@content.title).to eq(last_created_content.title)
      expect(@content.content_type).to eq(last_created_content.content_type)
      expect(@content.rank).to eq(last_created_content.rank)

      expect(response).to redirect_to(manage_course_chapter_contents_url(@course, @chapter))
      expect(flash[:notice]).to eq("Your content was created successfully.")
    end
  end

  describe "GET 'edit'" do
    before do
      @content = FactoryBot.create(:content, chapter: @chapter)
    end
    it "should be successful" do
      get :edit, params: {course_id: @course.id, chapter_id: @chapter.id, id: @content.id}
      expect(assigns(:content)).not_to be_new_record
      expect(response).to render_template("edit")
      expect(response).to be_successful
    end
  end

  describe "PUT 'update'" do
    before do
      @content = FactoryBot.create(:content, chapter: @chapter)
    end
    it "should be successful" do
      put :update, params: {course_id: @course.id, chapter_id: @chapter.id, id: @content.id, content: {title: "test content"}}
      @content.reload
      expect(response).to redirect_to(manage_course_chapter_contents_url(@course, @chapter))
      expect(@content.title).to eq("test content")
      expect(flash[:notice]).to eq("Your content was updated successfully.")
    end
  end

end
