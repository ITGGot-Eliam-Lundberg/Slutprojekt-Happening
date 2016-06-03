class Seeder

  def self.seed!
    self.users
    self.happenings
    self.participations
    self.followings
  end

  def self.users
    User.create(e_mail: "elund.98@gmail.com",
                full_name: "Eliam Lundberg",
                password: "bajs",
                description: "Jag älskar fotboll och tjejer! <33",
                picture: "/avatar/1.png")
    User.create(e_mail: "elund.trash@gmail.com",
                full_name: "Hello My Friend",
                password: "bajs",
                description: "Everyone is a friend of mine")
    User.create(e_mail: "elund.trash@test.com",
                full_name: "Maile Grebdnul",
                password: "bajs",
                description: "Backwardzzzlololol")
  end

  def self.happenings
    Happening.create(user_id: 2,
                     name: "Fotboll på heden",
                     description: "Ta med dina vänner och var med på vår turnering!",
                     price: 170)
  end

  def self.participations
    Participation.create(user_id: 2, happening_id: 1)

  end

  def self.followings
    Following.create(follower_id: 1, followee_id: 2)
    Following.create(follower_id:2, followee_id: 3)
  end
end