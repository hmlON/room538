module ApplicationHelper
  def flash_key_alert_class(key)
    flash_to_alert = {
      'notice' => 'info',
      'alert' => 'danger'
    }
    flash_to_alert[key]
  end
end
