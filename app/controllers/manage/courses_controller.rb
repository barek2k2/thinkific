class Manage::CoursesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @courses = @courses.includes(:chapters).paginate page: params[:page], per_page: 10
  end

  def new

  end

  def create
    @course.author = current_user
    if @course.save
      redirect_to manage_courses_path, notice: "Your course was created successfully."
    else
      render "new"
    end
  end

  def edit

  end

  def update
    if @course.update(course_params)
      redirect_to manage_courses_path, notice: "Your course was updated successfully."
    else
      render "edit"
    end
  end

  private

  def course_params
    params.require(:course).permit(:name, :subtitle, :description, :price, :duration)
  end
end
