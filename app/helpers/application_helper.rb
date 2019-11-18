module ApplicationHelper
  def breadcrumbs
    html = ""
    if params[:controller] == 'manage/contents'
      html << link_to("Courses -> ", manage_courses_path)
      html << link_to("Chapters -> ", manage_course_chapters_path(@course))
    elsif params[:controller] == 'manage/chapters'
      html << link_to("Courses -> ", manage_courses_path)
    end
    html.html_safe
  end
end
