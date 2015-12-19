module UserHelper
  def username_link(user = nil)
    content = [
      image_tag(user.avatar.url(:normal), class: :avatar, alt: user.title),
      content_tag(:strong, user.full_name, class: 'full-name'),
      content_tag(:span, "@#{user.screen_name}", class: 'screen-name')
    ].join("\n").html_safe

    link_to content, user_path(user), class: :username, title: user.title
  end

  def follow_link(user)
    if current_user.eql?(user)
      link_to 'Edit profile', '#', class: 'btn btn-default btn-sm'
    else
      partial = if user_signed_in?
        current_user.following?(user) ? 'button_unfollow' : 'button_follow'
      else
        'button_follow'
      end

      render("users/#{partial}", user: user)
    end
  end
end
