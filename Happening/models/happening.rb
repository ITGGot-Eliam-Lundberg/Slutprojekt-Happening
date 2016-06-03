class Happening
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :required => true
  property :description, String
  property :start_time, DateTime#, :required => true
  property :end_time, DateTime#, :required => true
  #property :location, Något, :unique => true
  property :picture, FilePath
  #property :category,
  property :price, Integer
  #property :status,

  has n, :participations
  has n, :users, :through => :participations
  belongs_to :user
end