module StoriesHelper
  def link_to_story(story)
    link_to story.title, story_path(story)
  end

  def popular_random_image( posts, size, n )
    res = ''
    n.times do |i|
      post = posts.sample
      res += (link_to (image_tag post.image(size)), story_post_path(post.story,post))
      res += '<br/>'
    end
    res.html_safe
  end

  def popular_column( posts, size )
    case size
    when :small
      popular_random_image posts, :small_crop, 2
    when :medium
      popular_random_image posts, :medium_crop, 1
    end
  end
end
