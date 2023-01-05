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


# # 1
# # Get all users

# repo = UserRepository.new

# users = repo.all

# users.length # =>  2

# users[0].id # =>  1
# users[0].username # =>  'David'
# users[0].user_email # =>  'david@gmail.com'

# users[1].id # =>  2
# users[1].username # =>  'Anna'
# users[1].user_email # =>  'anna@gmail.com'

# # 2
# # Get a single user

# repo = UserRepository.new

# user = repo.find(1)

# user.id # =>  1
# user.username # =>  'David'
# user.user_email # =>  'david@gmail.com'

# # 3
# # Get a single user

# repo = UserRepository.new

# user = repo.find(2)

# user.id # =>  2
# user.username # =>  'Anna'
# user.user_email # =>  'anna@gmail.com'

# # 4
# # Create a user entry

# repo = UserRepository.new

# user = User.new
# user.username = 'Louis'
# user.user_email = 'louis@gmail.com'

# repo.create(user)

# users = repo.all
# last_user = users.last
# last_user.username #=> 'Louis'
# last_user.user_email #=> 'louis@gmail.com'

# # 5
# # Update a user entry

# repo = UserRepository.new

# user = repo.find(1)
# user.username = 'David'
# user.user_email = 'david2001@gmail.com'

# repo.update(user)

# updated_user = repo.find(1)
# updated_user.id # => '1'
# updated_user.username # => 'David'
# updated_user.user_email # => 'david2001@gmail.com'

# # 6
# # Delete a user entry

# repo = UserRepository.new

# delete_user = repo.delete('2')
# users = repo.all

# users.length # => 1

# first_user = users.first
# first_user.id # => '1'
# first_user.username # => 'David'
# first_user.user_email # => 'david@gmail.com' 
# ```