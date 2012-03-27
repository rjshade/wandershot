puts 'EMPTY THE MONGODB DATABASE'
Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)

puts 'SETTING UP DEFAULT USER LOGIN'

user = User.create! :name => 'First User', :email => 'user@example.com', :password => 'please', :password_confirmation => 'please'
puts 'New user created: ' << user.name


summary = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam molestie nunc eu nulla aliquam aliquet. Sed porttitor lacus metus. Etiam vel ipsum nunc. Phasellus felis nisi, luctus id volutpat non, pharetra in mi. Nulla sed velit ac risus sollicitudin euismod a id tortor. Proin consequat, neque et facilisis tincidunt, arcu dolor sodales justo, at pulvinar odio metus ac justo. Proin magna metus, dignissim sed egestas id, aliquet quis risus. Maecenas fermentum pellentesque purus auctor laoreet.

Integer varius aliquet vulputate. Fusce id purus felis, vitae commodo lacus. Suspendisse potenti. Vivamus fringilla consectetur ligula, posuere volutpat nisl lobortis eu. In mauris velit, mattis vitae accumsan quis, lacinia quis ipsum. Quisque lorem enim, cursus in dignissim id, mollis vitae elit. Maecenas arcu quam, semper eu vestibulum ut, elementum eu metus. Donec risus diam, hendrerit quis sagittis et, rutrum consectetur elit. Aliquam non justo sit amet urna euismod ultricies. Nunc rhoncus egestas posuere.'


3.times do |s|
  story = user.stories.create! title: "Exciting story #{s}", summary: summary

  4.times do |i|
    post = story.posts.create! title: "Entry number #{i}", text: summary, image_path: "stock/stock_#{(0..8).to_a.shuffle.first}.jpg"
  end
  puts "Story #{s} created"
end

