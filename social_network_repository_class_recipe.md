# Social Network Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: students

Columns:
id | name | cohort_name
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

# Table 1
```sql

TRUNCATE TABLE users RESTART IDENTITY; -- replace with your own table name.

INSERT INTO users (username, user_email) VALUES ('David', 'david@gmail.com');
INSERT INTO users (username, user_email) VALUES ('Anna', 'anna@gmail.com');

```
# Table 2
```sql
TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table name.

INSERT INTO posts (title, content, views, user_id) VALUES ('Post 1', 'Test content for post 1', '20', '1');
INSERT INTO posts (title, content, views, user_id) VALUES ('Post 2', 'Test content for post 2', '10', '2');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: users

# Model class
# (in lib/user.rb)
class User
end

# Table name: posts

# Model class
# (in lib/post.rb)
class Post
end

# Repository class
# (in lib/user_repository.rb)
class UserRepository
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class User
  attr_accessor :id, :username, :user_email
end

class Post
  attr_accessor :id, :title, :content, :views, :user_id
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# Table 1 name: users

# Repository class
# (in lib/user_repository.rb)

class UserRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, username, user_email FROM users;

    # Returns an array of User objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, username, user_email FROM users WHERE id = $1;

    # Returns a single User object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(user)
    # Executes the SQL query:
    # INSERT INTO users (username, user_email) VALUES($1, $2);

    # returns nothing
  end

  def update(user)
   # Executes the SQL query:
   # UPDATE users SET username = $1, user_email = $2 WHERE id = $3
  end

  def delete(user)
    # Executes the SQL query:
    # DELETE FROM users WHERE id = $1
  end
end

# Table 2 name: posts

# Repository class
# (in lib/post_repository.rb)

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




```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

UserRepository Tests
```ruby
# EXAMPLES

# 1
# Get all users

repo = UserRepository.new

users = repo.all

users.length # =>  2

users[0].id # =>  1
users[0].username # =>  'David'
users[0].user_email # =>  'david@gmail.com'

users[1].id # =>  2
users[1].username # =>  'Anna'
users[1].user_email # =>  'anna@gmail.com'

# 2
# Get a single user

repo = UserRepository.new

user = repo.find(1)

user.id # =>  1
user.username # =>  'David'
user.user_email # =>  'david@gmail.com'

# 3
# Get a single user

repo = UserRepository.new

user = repo.find(2)

user.id # =>  2
user.username # =>  'Anna'
user.user_email # =>  'anna@gmail.com'

# 4
# Create a user entry

repo = UserRepository.new

user = User.new
user.username = 'Louis'
user.user_email = 'louis@gmail.com'

repo.create(user)

users = repo.all
last_user = users.last
last_user.username #=> 'Louis'
last_user.user_email #=> 'louis@gmail.com'

# 5
# Update a user entry

repo = UserRepository.new

user = repo.find(1)
user.username = 'David'
user.user_email = 'david2001@gmail.com'

repo.update(user)

updated_user = repo.find(1)
updated_user.id # => '1'
updated_user.username # => 'David'
updated_user.user_email # => 'david2001@gmail.com'

# 6
# Delete a user entry

repo = UserRepository.new

delete_user = repo.delete('2')
users = repo.all

users.length # => 1

first_user = users.first
first_user.id # => '1'
first_user.username # => 'David'
first_user.user_email # => 'david@gmail.com' 
```

PostRepository Tests
```ruby
# EXAMPLES

# 1
# Get all posts

repo = PostRepository.new

posts = repo.all

posts.length # =>  2

posts[0].id # =>  1
posts[0].title # =>  'Post 1'
posts[0].content # =>  'Test content for post 1'
posts[0].views # =>  '20'
posts[0].user_id # => '1'

posts[1].id # =>  2
posts[1].title # =>  'Post 2'
posts[1].content # =>  'Test content for post 2'
posts[1].views # =>  '10'
posts[1].user_id # => '2'

# 2
# Get a single post

repo = PostRepository.new

post = repo.find(1)

post.id # =>  1
post.title # => 'Post 1'
post.content # => 'Test content for post 1'
post.views # => '20'
post.user_id # => '1'

# 2
# Get a single post

repo = PostRepository.new

post = repo.find(2)

post.id # =>  2
post.title # => 'Post 2'
post.content # => 'Test content for post 2'
post.views # => '10'
post.user_id # => '2'

# 4
# Create a post entry

repo = PostRepository.new

post = Post.new
post.title = 'Post 3'
post.content = 'Test content for post 3'
post.views = '100'
post.user_id = '2'

repo.create(post)

posts = repo.all
last_post = pots.last
last_post.title # => 'Post 3'
last_post.content # => 'Test content for post 3'
last_post.views # => '100'
post.user_id # => '2'

# 5
# Update a post entry

repo = PostRepository.new

post = repo.find(1)
post.title = 'Post 1'
post.content = 'Changed the content for post 1'
post.views = '23'
post.user_id = '1'

repo.update(post)

updated_post = repo.find(1)
updated_post.id # => '1'
updated_post.title # => 'Post 1'
updated_post.content # => 'Changed the content for post 1'
updated_post.views # => '23'
updated_post.user_id # => '1'

# 6
# Delete a user entry

repo = PostRepository.new

delete_post = repo.delete('2')
posts = repo.all

posts.length # => 1

first_post = posts.first
first_post.id # => '1'
first_post.title # => 'Post 1'
first_post.content # => 'Test content for post 1'
first_post.views # => '20'
first_post.user_id # => '1'
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/user_repository_spec.rb

def reset_users_table
  seed_sql = File.read('spec/seeds_users.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe UserRepository do
  before(:each) do 
    reset_users_table
  end

  # (your tests will go here).
end

# file: spec/post_repository_spec.rb

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
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->
