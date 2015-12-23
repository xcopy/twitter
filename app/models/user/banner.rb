class User::Banner < Asset
  URL = '/uploads/:rails_env/:resource_type/:resource_id/banner/:style.:extension'

  has_attached_file :attachment,
    default_url: '//pbs.twimg.com/profile_banners/6253282/1431474710/1500x500',
    path: ":rails_root/public#{URL}",
    url: URL,
    styles: {
      big: '1500x500#',
      medium: '600x200#',
      small: '300x100#'
    }

  validates_attachment_content_type :attachment, content_type: /\Aimage\/.*\Z/
end