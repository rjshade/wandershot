module PostsHelper
  def link_to_post(post)
    link_to post.title, story_post_path(post.story, post)
  end
end
