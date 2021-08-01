module ApplicationHelper
    def liked?(tweet)
        tweet.likes.where(user_id: current_user[:id]).any?
    end

    def original_tweet(tweet)
        Tweet.find(tweet.retweeted_id)
    end 

    def retweet_author(tweet)
        author_id = Tweet.find(tweet.retweeted_id).user_id
        author = []
        author = User.find(author_id)
    end   
    
    def rt_author_tweet(tweet)  
        original_tweet = Tweet.find(tweet.retweeted_id)
    end

    def tweet_likes(tweet)
        likes = Like.where("tweet_id = ?", tweet.id)
    end



    def liked_by(like)
        liked_by = User.where("id = ?", like.user_id).first
    end

    
end
