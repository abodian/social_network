require_relative "./user"

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