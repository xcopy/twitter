class User::Avatar < Asset
  URL = '/uploads/:rails_env/:resource_type/:resource_id/avatar/:style.:extension'

  has_attached_file :attachment,
    default_url: '//abs.twimg.com/sticky/default_profile_images/default_profile_0_:style.png',
    path: ":rails_root/public#{URL}",
    url: URL,
    styles: {
      bigger: '73x73#',
      normal: '48x48#',
      thumb: '34x34#',
      mini: '24x24#'
    }

  validates_attachment_content_type :attachment, content_type: /\Aimage\/.*\Z/
end