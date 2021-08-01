class ApiController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods
http_basic_authenticate_with name: "nico@gmail.com", password: "123456", only:
:create

skip_before_action :verify_authenticity_token


     
  
      def index
        tweets = Tweet.all

    respond_to do |format|
      format.json { render json: tweets }
      format.xml  { render xml: tweets }
      end
      end

       

      def news
        news_arr = []
        jtweets = Tweet.last(50)
         jtweets.each do |t|
         news_arr << {
            id: t.id,
            content: t.content,
            user_id: t.user_id,
            likes_count: t.likes.count,
            retweets_count: Tweet.where("retweeted_id = ?", t.id).count,
            retweeted_from: Tweet.where("id = ?", t.retweeted_id).ids
          }
         end

        respond_to do |format|
          format.json { render json: news_arr }
          format.xml  { render xml: news_arr }
        end
      end  

      def between
        between_arr = []
         fecha1 = params[:fecha1]
         fecha2 = params[:fecha2]
         selected_tweets = Tweet.where(:created_at => fecha1..fecha2)
         selected_tweets.each do |t|
          between_arr << {
             id: t.id,
             content: t.content,
             user_id: t.user_id,
             likes_count: t.likes.count,
             retweets_count: Tweet.where("retweeted_id = ?", t.id).count,
             retweeted_from: Tweet.where("id = ?", t.retweeted_id).ids
           }
          end
         respond_to do |format|
          format.json { render json: between_arr }
          format.xml  { render xml: between_arr }
         end
      end

      def create
        @tweet = Tweet.new(tweet_params)
    
        if @tweet.save
          render json: @tweet, status: :created, location: @tweet
        else
          render json: @tweet.errors, status: :unprocessable_entity
        end
      end

      #private

      def tweet_params
          params.require(:tweet).permit(:user_id, :content, :retweeted_id)
      end 
      

      


         
     
    
end