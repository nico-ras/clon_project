class TweetsController < ApplicationController
    before_action :set_tweet, only: [:show, :edit, :update, :destroy]

    def index
      
        @tweet = Tweet.new
          if user_signed_in?
            @tweets = Tweet.tweets_for_me(current_user.id)
          else    
            @tweets = Tweet.all
          end
        @q = @tweets.ransack(params[:q])
        @tweets = @q.result(distinct: true)
        @tweets = @tweets.order(:date).page(params[:page]).per(50)
    end

    def hashtags
      tag = Tag.find_by(name: params[:name])
      @tweets = tag.tweets
    end  

    

    def show
    end
    
    def new
        @tweet = Tweet.new
    end

    def edit
    end
  
    def create
        @tweet = Tweet.new(tweet_params)
        @tweet.user = current_user
        respond_to do |format|
            if @tweet.save
                format.html { redirect_to tweets_path, notice: 'Tweet was successfully created.' }
            else 
                format.html { render :new } 
            end
        end           
    end

    def update
        respond_to do |format|
          if @tweet.update(tweet_params)
            format.html { redirect_to @tweet, notice: "Tweet was successfully updated." }
            format.json { render :show, status: :ok, location: @tweet }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @tweet.errors, status: :unprocessable_entity }
          end
        end
      end
  
    def destroy
        if @tweet[:user_id] == current_user[:id]
            @tweet.destroy
            respond_to do |format|
                format.html { redirect_to tweets_path, notice: 'Tweet was successfully delete.' }
            end
        end        
    end

    def retweet
        @retweet = Tweet.find(params[:tweet_id])
        @tweet = Tweet.new
          
    end 

   

    private

    def set_tweet
      @tweet = Tweet.find(params[:id])
    end
    
    def tweet_params
        params.require(:tweet).permit(:content, :retweeted_id)
    end 
    
       
end
