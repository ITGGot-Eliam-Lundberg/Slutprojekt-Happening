class Following
  include DataMapper::Resource

  belongs_to :follower, 'User', :key => true
  belongs_to :followee, 'User', :key => true
end