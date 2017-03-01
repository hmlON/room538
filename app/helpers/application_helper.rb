module ApplicationHelper
  def title(page_title)
    content_for :title, page_title.to_s
  end

  def flash_key_alert_class(key)
    flash_to_alert = {
      'notice' => 'info',
      'alert' => 'danger'
    }
    flash_to_alert[key]
  end
end
