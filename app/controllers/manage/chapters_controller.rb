class Manage::ChaptersController < ApplicationController
  before_action :authenticate_user!

  load_and_authorize_resource :course
  load_and_authorize_resource :chapter, through: :course

  def index
    @chapters = @chapters.asc.includes(:course, :contents).paginate page: params[:page], per_page: 10
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

  def bulk_import
    if request.post?
      if params[:bulk_import].present? && params[:bulk_import][:csv].present?
        @chapter.import_contents_from(params[:bulk_import][:csv])
        redirect_to manage_course_chapter_contents_url(@course, @chapter), notice: "Multimedia content(s) were imported successfully."
      else
        redirect_to manage_course_chapters_path(@course), alert: "Please choose valid csv to import contents."
      end
    end
  end

  private

  def chapter_params
    params.require(:chapter).permit(:title, :rank)
  end
end
