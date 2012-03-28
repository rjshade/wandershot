Paperclip.interpolates :user_slug do |attachment, style|
  attachment.instance.story.user.slug
end
Paperclip.interpolates :story_slug do |attachment, style|
  attachment.instance.story.slug
end
Paperclip.interpolates :post_slug do |attachment, style|
  attachment.instance.slug
end
