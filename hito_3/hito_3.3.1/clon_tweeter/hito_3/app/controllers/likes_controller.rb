class LikesController < ApplicationController
before_action :set_like, :already_liked?, only: [:destroy]
before_action :set_tweet, :already_liked?, only: [:create]


  def new
    @like = Tweet.new
  end

  def create 
    if user_signed_in?
     @tweet.likes.create(user_id: current_user.id) 
     redirect_to tweets_path 
    end 
  end

  def destroy
    if user_signed_in?
      @like.destroy 
      redirect_to tweets_path
    end  
  end  

  

  private

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end 
  
  def already_liked?
    Like.where(user_id: current_user.id, tweet_id: params[:tweet_id]).present?
  end
  
  def set_like
    @like = Like.find(params[:id])
  end  
end

