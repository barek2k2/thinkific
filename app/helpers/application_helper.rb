module ApplicationHelper
  def breadcrumbs
    html = ""
    if params[:controller] == 'manage/contents'
      html << link_to("Courses -> ", manage_courses_path)
      html << link_to("Chapters -> ", manage_course_chapters_path(@course))
      html << link_to("Contents -> ", manage_course_chapter_contents_path(@course, @chapter)) if @chapter.present? && params[:action] == 'bulk_import'
    elsif params[:controller] == 'manage/chapters'
      html << link_to("Courses -> ", manage_courses_path)
      html << link_to("Chapters -> ", manage_course_chapters_path(@course)) if @chapter.present?
    end
    html.html_safe
  end
end
