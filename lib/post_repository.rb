require_relative "./post"

class PostRepository

  # Selecting all records
  # No arguments
  def all
    sql = "SELECT id, title, content, views, user_id FROM posts;"
    result_set = DatabaseConnection.exec_params(sql, [])

    posts = []

    result_set.each do |record|
      post = Post.new
      post.id = record['id']
      post.title = record['title']
      post.content = record['content']
      post.views = record['views']
      post.user_id = record['user_id']
      
      posts << post
    end
    return posts
  end

  def find(id)
    sql = "SELECT id, title, content, views, user_id FROM posts WHERE id = $1;"
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]

    post = Post.new
    post.id = record['id']
    post.title = record['title']
    post.content = record['content']
    post.views = record['views']
    post.user_id = record['user_id']
    return post
  end

  def create(post)
    # Executes the SQL query:
    sql = "INSERT INTO posts (title, content, views, user_id) VALUES($1, $2, $3, $4);"
    params = [post.title, post.content, post.views, post.user_id]
    DatabaseConnection.exec_params(sql, params)

    return nil
  end

  def update(post)
    sql = "UPDATE posts SET title = $1, content = $2, views = $3, user_id = $4 WHERE id = $5"
    params = [post.title, post.content, post.views, post.user_id, post.id]
    DatabaseConnection.exec_params(sql, params)

    return nil
  end

  def delete(post_id)
    sql = "DELETE FROM posts WHERE id = $1"
    params = [post_id]
    DatabaseConnection.exec_params(sql, params)

    return nil
  end
end