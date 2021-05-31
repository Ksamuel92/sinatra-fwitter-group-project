class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true


  def slug
    #  binding.pry
    self.username.gsub(" ", "-").to_s
  end

  def self.find_by_slug(slug)
    self.all.find{ |instance| instance.slug == slug }
  end

end
