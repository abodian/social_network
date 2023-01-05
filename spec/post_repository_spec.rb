require_relative "../lib/post_repository"

def reset_posts_table
  seed_sql = File.read('spec/seeds_users_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_posts_table
  end

  it 'gets all posts' do
    repo = PostRepository.new

    posts = repo.all

    expect(posts.length).to eq 2

    expect(posts[0].id).to eq "1"
    expect(posts[0].title).to eq "Post 1" 
    expect(posts[0].content).to eq "Test content for post 1" 
    expect(posts[0].views).to eq "20" 
    expect(posts[0].user_id).to eq "1" 

    expect(posts[1].id).to eq "2"
    expect(posts[1].title).to eq "Post 2" 
    expect(posts[1].content).to eq "Test content for post 2" 
    expect(posts[1].views).to eq "10" 
    expect(posts[1].user_id).to eq "2" 
  end

  it "gets a single post" do
    repo = PostRepository.new

    post = repo.find(1)

    expect(post.id).to eq "1"
    expect(post.title).to eq "Post 1"
    expect(post.content). to eq "Test content for post 1"
    expect(post.views).to eq "20"
    expect(post.user_id).to eq "1"
  end

  it "gets a single post" do
    repo = PostRepository.new

    post = repo.find(2)

    expect(post.id).to eq "2"
    expect(post.title).to eq "Post 2"
    expect(post.content). to eq "Test content for post 2"
    expect(post.views).to eq "10"
    expect(post.user_id).to eq "2"
  end

  it "creates a post entry" do
    repo = PostRepository.new

    post = Post.new
    post.title = 'Post 3'
    post.content = 'Test content for post 3'
    post.views = '100'
    post.user_id = '2'

    repo.create(post)

    posts = repo.all
    last_post = posts.last
    expect(last_post.title).to eq "Post 3" # => 'Post 3'
    expect(last_post.content).to eq "Test content for post 3" # => 'Test content for post 3'
    expect(last_post.views).to eq "100" # => '100'
    expect(last_post.user_id).to eq "2"
  end

  it "updates a post entry" do
    repo = PostRepository.new

    post = repo.find(1)
    post.title = 'Post 1'
    post.content = 'Changed the content for post 1'
    post.views = '23'
    post.user_id = '1'

    repo.update(post)

    updated_post = repo.find(1)
    expect(updated_post.id).to eq "1"
    expect(updated_post.title).to eq "Post 1"
    expect(updated_post.content).to eq "Changed the content for post 1"
    expect(updated_post.views).to eq "23"
    expect(updated_post.user_id).to eq "1"
  end

  it "deletes a user entry" do
    repo = PostRepository.new

    delete_post = repo.delete('2')
    posts = repo.all

    expect(posts.length).to eq 1

    first_post = posts.first
    expect(first_post.id).to eq "1"
    expect(first_post.title).to eq "Post 1"
    expect(first_post.content).to eq "Test content for post 1"
    expect(first_post.views).to eq "20"
    expect(first_post.user_id).to eq "1"
  end
end


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