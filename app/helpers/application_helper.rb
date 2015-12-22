module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def close_modal
    button_tag '&times;'.html_safe, type: :button, class: :close, data: {dismiss: :modal}
  end
end
