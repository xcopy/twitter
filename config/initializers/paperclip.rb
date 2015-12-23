Paperclip.interpolates :resource_type do |attachment, style|
  resource = attachment.instance.resource
  plural_cache = Paperclip::Interpolations::PluralCache.new
  plural_cache.underscore_and_pluralize_class(resource.class)
end

Paperclip.interpolates :resource_id do |attachment, style|
  attachment.instance.resource.id
end
