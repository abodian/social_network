require_relative 'lib/database_connection'
require_relative 'lib/user_repository'
require_relative 'lib/post_repository'

DatabaseConnection.connect('social_network')


user_repository = UserRepository.new

user_repository.all.each do |user|
  puts user.username
end

single_user = user_repository.find(1)

puts single_user.id