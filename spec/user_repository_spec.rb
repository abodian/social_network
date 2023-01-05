require_relative "../lib/user_repository"


def reset_users_table
  seed_sql = File.read('spec/seeds_users_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe UserRepository do
  before(:each) do 
    reset_users_table
  end

  it "gets all user" do
    repo = UserRepository.new
    users = repo.all
    
    expect(users.length).to eq 2

    expect(users[0].id).to eq '1'
    expect(users[0].username).to eq 'David'
    expect(users[0].user_email).to eq 'david@gmail.com'

    expect(users[1].id).to eq '2'
    expect(users[1].username).to eq 'Anna'
    expect(users[1].user_email).to eq 'anna@gmail.com'
  end

  it "gets a single user" do
    repo = UserRepository.new

    user = repo.find(1)

    expect(user.id).to eq "1"
    expect(user.username).to eq "David"
    expect(user.user_email).to eq "david@gmail.com"
  end

  it "gets a single user" do
    repo = UserRepository.new

    user = repo.find(2)

    expect(user.id).to eq "2"
    expect(user.username).to eq "Anna"
    expect(user.user_email).to eq "anna@gmail.com"
  end

  it "creates a user entry" do
    repo = UserRepository.new

    user = User.new
    user.username = 'Louis'
    user.user_email = 'louis@gmail.com'

    repo.create(user)

    users = repo.all
    last_user = users.last
    expect(last_user.username).to eq "Louis" #=> 'Louis'
    expect(last_user.user_email).to eq "louis@gmail.com" #=> 'louis@gmail.com'
  end

  it "updates a user entry" do
    repo = UserRepository.new

    user = repo.find(1)
    user.username = 'David'
    user.user_email = 'david2001@gmail.com'

    repo.update(user)

    updated_user = repo.find(1)
    expect(updated_user.id).to eq "1"
    expect(updated_user.username).to eq "David"
    expect(updated_user.user_email).to eq "david2001@gmail.com"
  end

  it "deletes a user entry" do
    repo = UserRepository.new

    delete_user = repo.delete('2')
    users = repo.all

    expect(users.length).to eq 1

    first_user = users.first
    expect(first_user.id).to eq "1" 
    expect(first_user.username).to eq "David"
    expect(first_user.user_email).to eq "david@gmail.com" 
  end
end