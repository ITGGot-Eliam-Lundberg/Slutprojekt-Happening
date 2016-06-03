class Participation
  include DataMapper::Resource

  property :id, Serial
  #property :status, Enum (Kolla upp)

  belongs_to :user
  belongs_to :happening
end