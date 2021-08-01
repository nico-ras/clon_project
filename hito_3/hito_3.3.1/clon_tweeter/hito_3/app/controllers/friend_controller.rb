class FriendController < ApplicationController

    def index
        @friends = Friend.where("user_id = ?", current_user)

    end    

    def new
        @friend = Friend.new
    end
    
    def create
        @friend = Friend.new(friend_params)
        @story.user = current_user
        respond_to do |format|
            if @story.save
              format.html { redirect_to tweets_path, notice: 'now you floowed it.' }
              format.json { render :show, status: :created, location: @story }
            else
              format.html { render :new }
              format.json { render json: @friend.errors, status: :unprocessable_entity }
            end
        end    
    end
    
    def destroy
    end


end
