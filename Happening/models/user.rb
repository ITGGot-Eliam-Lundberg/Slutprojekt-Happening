class User
  include DataMapper::Resource

  property :id, Serial
  property :e_mail, String, :required => true, :unique => true
  property :full_name, String, :required => true, :length => 2..25
  property :password, BCryptHash, :required => true
  property :birth_date, Date
  # property :position,
  # property :hometown,
  property :phone_number, String, :unique => true
  property :picture, FilePath, :default => '/img/standard.png'
  property :description, String, :length => 0..150
  property :first_time, Boolean, :default => true

  has n, :participations
  has n, :happenings, :through => :participations
  has n, :followings, :child_key => [:follower_id]
  has n, :followees, self, :through => :followings, :via => :followee
  has n, :followers, self, :through => :followings, :via => :follower
end

class Admin
  include DataMapper::Resource

  property :id, Serial

  belongs_to :user
end