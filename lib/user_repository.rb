require_relative "./user"

class UserRepository
  def all
    sql = "SELECT id, username, user_email FROM users;"
    result_set = DatabaseConnection.exec_params(sql, [])

    users = []

    result_set.each do |record|
      user = User.new
      user.id = record['id']
      user.username = record['username']
      user.user_email = record['user_email']

      users << user
    end
    return users
  end

  def find(id)
    sql = "SELECT id, username, user_email FROM users WHERE id = $1;"
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]

    user = User.new
    user.id = record['id']
    user.username = record['username']
    user.user_email = record['user_email']
    return user
  end

  def create(user)
    sql = "INSERT INTO users (username, user_email) VALUES($1, $2);"
    params = [user.username, user.user_email]
    DatabaseConnection.exec_params(sql, params)

    return nil
  end

  def update(user)
   sql = "UPDATE users SET username = $1, user_email = $2 WHERE id = $3"
   params = [user.username, user.user_email, user.id]
   DatabaseConnection.exec_params(sql, params)

   return nil
  end

  def delete(user)
    sql = "DELETE FROM users WHERE id = $1"
    params = [user]
    DatabaseConnection.exec_params(sql, params)
  end
end