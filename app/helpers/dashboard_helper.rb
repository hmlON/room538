module DashboardHelper
  def progress_tag(current:, min: 0, max: 100)
    width_persentage = current.zero? ? 0 : (current - min) * 100 / (max - min)
    content_tag(:div,
                content_tag(:div, '',
                            class: 'progress-bar',
                            'aria-valuemax' => max,
                            'aria-valuemin' => min,
                            'aria-valuenow' => current,
                            'role' => 'progressbar',
                            'style' => "width: #{width_persentage}%"),
                class: 'progress')
  end

  def activity_time_tag(time)
    content_tag(:span,
                time_ago_in_words(time) + ' ago.',
                class: 'activity--time',
                title: time.strftime('%d %b %Y %T %Z'))
  end
end
