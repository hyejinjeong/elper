class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :time_slots, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :events, through: :participations
  # Include default devise modules. Others available are:

    # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  enum category: { admin: 0, mentor: 1, mentee: 2 }

  def self.find_for_facebook_oauth(auth)
    user = where(:provider=>auth.provider, :uid=>auth.uid).first_or_create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
    end
  end  

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def manager
    id == 1 || category == 0
  end

  def mentor
    category == 1
  end

  def mentee
    category == 2
  end

end
