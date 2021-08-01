class RetweetsController < ApplicationController
  def new
    @retweet = Retweet.new
  end

  def create
    @retweet = Retweet.new(retweet_params)
    @retweet.tweet = @tweet
    respond_to do |format|
      if @retweet.save
        format.html { redirect_to @story, notice: 'Tweet was successfully created.' }
      else
        format.html { render :new }
      end
    end    
  end

  def destroy
  end

  private 

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
  
  
end
