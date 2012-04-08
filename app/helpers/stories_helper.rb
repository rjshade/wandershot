module StoriesHelper
  def link_to_story(story)
    link_to story.title, story_path(story)
  end
end
