def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_posts_table
  end

  # (your tests will go here).
end

# # 1
# # Get all posts

# repo = PostRepository.new

# posts = repo.all

# posts.length # =>  2

# posts[0].id # =>  1
# posts[0].title # =>  'Post 1'
# posts[0].content # =>  'Test content for post 1'
# posts[0].views # =>  '20'
# posts[0].user_id # => '1'

# posts[1].id # =>  2
# posts[1].title # =>  'Post 2'
# posts[1].content # =>  'Test content for post 2'
# posts[1].views # =>  '10'
# posts[1].user_id # => '2'

# # 2
# # Get a single post

# repo = PostRepository.new

# post = repo.find(1)

# post.id # =>  1
# post.title # => 'Post 1'
# post.content # => 'Test content for post 1'
# post.views # => '20'
# post.user_id # => '1'

# # 2
# # Get a single post

# repo = PostRepository.new

# post = repo.find(2)

# post.id # =>  2
# post.title # => 'Post 2'
# post.content # => 'Test content for post 2'
# post.views # => '10'
# post.user_id # => '2'

# # 4
# # Create a post entry

# repo = PostRepository.new

# post = Post.new
# post.title = 'Post 3'
# post.content = 'Test content for post 3'
# post.views = '100'
# post.user_id = '2'

# repo.create(post)

# posts = repo.all
# last_post = pots.last
# last_post.title # => 'Post 3'
# last_post.content # => 'Test content for post 3'
# last_post.views # => '100'
# post.user_id # => '2'

# # 5
# # Update a post entry

# repo = PostRepository.new

# post = repo.find(1)
# post.title = 'Post 1'
# post.content = 'Changed the content for post 1'
# post.views = '23'
# post.user_id = '1'

# repo.update(post)

# updated_post = repo.find(1)
# updated_post.id # => '1'
# updated_post.title # => 'Post 1'
# updated_post.content # => 'Changed the content for post 1'
# updated_post.views # => '23'
# updated_post.user_id # => '1'

# # 6
# # Delete a user entry

# repo = PostRepository.new

# delete_post = repo.delete('2')
# posts = repo.all

# posts.length # => 1

# first_post = posts.first
# first_post.id # => '1'
# first_post.title # => 'Post 1'
# first_post.content # => 'Test content for post 1'
# first_post.views # => '20'
# first_post.user_id # => '1'