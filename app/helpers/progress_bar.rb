class ProgressBar
  include ActionView::Helpers::TagHelper

  def initialize(current:, min: 0, max: 100, text: '')
    @current = current
    @min = min
    @max = max
    @text = text
  end

  def html_tag
    content_tag(:div,
                content_tag(:div, text,
                            class: "progress-bar #{'bg-danger' if current.negative?}",
                            'aria-valuemax' => max, 'aria-valuemin' => min, 'aria-valuenow' => current,
                            'role' => 'progressbar',
                            'style' => "width: #{width_persentage}%"),
                class: 'progress')
  end

  private

  attr_accessor :current, :min, :max, :text

  def width_persentage
    if current.zero?
      0
    elsif current.positive?
      current * 100 / max
    else
      current * 100 / (max + min)
    end
  end
end
