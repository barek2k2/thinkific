class Manage::ContentsController < ApplicationController

  load_and_authorize_resource :course
  load_and_authorize_resource :chapter, through: :course
  load_and_authorize_resource :content, through: :chapter

  def index
    @contents = @contents.includes(chapter: :course).paginate page: params[:page], per_page: 10
  end

  def new

  end

  def create
    @content.chapter = @chapter
    if @content.save
      redirect_to manage_course_chapter_contents_path(@course, @chapter), notice: "Your content was created successfully."
    else
      render "new"
    end
  end

  def edit

  end

  def update
    if @content.update(content_params)
      redirect_to manage_course_chapter_contents_path(@course, @chapter), notice: "your content was updated successfully."
    else
      render "edit"
    end
  end

  def destroy
    @content.destroy
    redirect_to manage_course_chapter_content_url(@course, @chapter), notice: "Content was deleted."
  end

  private

  def content_params
    params.require(:content).permit(:title, :content_type, :description, :chapter_id, files: [])
  end
end
