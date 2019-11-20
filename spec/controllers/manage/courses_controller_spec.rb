require 'rails_helper'

RSpec.describe Manage::CoursesController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  describe "GET 'index'" do
    it "should be successful" do
      get :index
      expect(assigns(:courses)).not_to be_nil
      expect(response).to render_template("index")
      expect(response).to be_successful
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      expect(assigns(:course)).to be_new_record
      expect(response).to render_template("new")
      expect(response).to be_successful
    end
  end

  describe "POST 'create'" do
    it "should be successful" do
      @course = FactoryBot.build(:course, author: @user)
      params = FactoryBot.attributes_for :course
      post :create, params: {course: params}
      last_created_course = Course.last
      expect(@course.name).to eq(last_created_course.name)
      expect(@course.subtitle).to eq(last_created_course.subtitle)
      expect(@course.description).to eq(last_created_course.description)
      expect(@course.price).to eq(last_created_course.price)
      expect(@course.duration).to eq(last_created_course.duration)
      expect(response).to redirect_to(manage_courses_url)
      expect(flash[:notice]).to eq("Your course was created successfully.")
    end
  end

  describe "GET 'edit'" do
    before do
      @course = FactoryBot.create(:course, author: @user)
    end
    it "should be successful" do
      get :edit, params: {id: @course.id}
      expect(assigns(:course)).not_to be_new_record
      expect(response).to render_template("edit")
      expect(response).to be_successful
    end
  end

  describe "PUT 'update'" do
    before do
      @course = FactoryBot.create(:course, author: @user)
    end
    it "should be successful" do
      put :update, params: {id: @course.id, course: {name: "test course"}}
      @course.reload
      expect(response).to redirect_to(manage_courses_url)
      expect(@course.name).to eq("test course")
      expect(flash[:notice]).to eq("Your course was updated successfully.")
    end
  end

end
