class Tweet < ApplicationRecord

  validates :content, presence: true
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_and_belongs_to_many :tags


  after_create do
    tweet = Tweet.find_by(id: self.id)
    hashtags = self.content.scan(/#\w+/)
    hashtags.map do |hashtag|
      tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
      tweet.tags << tag
    end  
  end

  before_update do
    tweet = Tweet.find_by(id: self.id)
    tweet.tags.clear
    hashtags = self.content.scan(/#\w+/)
    hashtags.map do |hashtag|
      tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
      tweet.tags << tag
    end
  end

  
   
   
   scope :tweets_for_me, ->(signed_user_id) {where(user_id: current_friends_ids(signed_user_id))} # aqui entrego los tweets segun los ids de los amigos de current_user
   
   def self.current_friends_ids(signed_user_id) #aqui obtengo user_ids de los amigos del current_user
    current_friendships = Friend.where("user_id = ?", signed_user_id)
    friends_ids = []
    friends_ids.push(signed_user_id)
    current_friendships.each {|u| friends_ids.push(u.friend_id)}
    friends_ids
end 


end
