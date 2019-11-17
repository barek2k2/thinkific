class Manage::ChaptersController < ApplicationController
  before_action :authenticate_user!

  load_and_authorize_resource :course
  load_and_authorize_resource :chapter, through: :course

  def index
    @chapters = @chapters.includes(:course, :contents).paginate page: params[:page], per_page: 10
  end

  def new

  end

  def create
    @chapter.course = @course
    if @chapter.save
      redirect_to manage_course_chapters_path(@course), notice: "Your chapter was created successfully."
    else
      render "new"
    end
  end

  def edit

  end

  def update
    if @chapter.update(chapter_params)
      redirect_to manage_course_chapters_path(@course), notice: "your chapter was updated successfully."
    else
      render "edit"
    end
  end

  private

  def chapter_params
    params.require(:chapter).permit(:title)
  end
end
