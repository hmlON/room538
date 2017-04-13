module DashboardHelper
  def progress_tag(current:, **options)
    ProgressBar.new(current: current, **options).html_tag
  end

  def activity_time_tag(time)
    content_tag(:span,
                time_ago_in_words(time) + ' ago.',
                class: 'activity--time',
                title: time.strftime('%d %b %Y %T %Z'))
  end
end
