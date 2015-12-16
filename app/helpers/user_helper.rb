module UserHelper
  def username_link(user = nil, screen_name_new_line = false)
    link_to user_path(user), class: :username, title: "#{user.full_name} (#{user.screen_name})" do
      content_tag(:span, user.full_name) + ' ' + content_tag(screen_name_new_line ? :div : :span, "@#{user.screen_name}", class: 'text-muted')
    end
  end

  def follow_link(user)
    if current_user.eql?(user)
      link_to 'Edit profile', '#', class: 'btn btn-default btn-sm'
    else
      partial = current_user.following?(user) ? 'button_unfollow' : 'button_follow'
      render("users/#{partial}", user: user)
    end
  end
end
