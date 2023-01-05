require_relative "./post"

class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, content, views, user_id FROM posts;

    # Returns an array of Post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, content, views, user_id FROM posts WHERE id = $1;

    # Returns a single Post object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(post)
    # Executes the SQL query:
    # INSERT INTO posts (title, content, views, user_id) VALUES($1, $2, $3, $4);

    # returns nothing
  end

  def update(post)
   # Executes the SQL query:
   # UPDATE posts SET title = $1, content = $2, views = $3, user_id = $4 WHERE id = $5
  end

  def delete(post)
    # Executes the SQL query:
    # DELETE FROM posts WHERE id = $1
  end
end