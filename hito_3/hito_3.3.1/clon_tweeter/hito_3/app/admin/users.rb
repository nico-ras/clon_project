ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :name, :profile_pic, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
     
  index do 
    selectable_column
    id_column
    column :name
    column :email
    column :created_at
    column :tweet_count do |u|
      columns u.tweets.count 
    end
    column :followed_count do |u|
      columns u.friends.ids.count 
    end
    column :likes_count do |u|
      columns u.likes.count 
    end
    column :retweet_count do |u|
      columns u.tweets.pluck(:retweeted_id).count
    end
    actions
  end 

module Views
  class IndexAsMyIdea < ActiveAdmin::Component

    def build(page_presenter, collection)
      # ...
    end

    def self.index
      
    end

  end

end
  #
  # or
  #
  # permit_params do
   #  permitted = [:name, :profile_pic, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
