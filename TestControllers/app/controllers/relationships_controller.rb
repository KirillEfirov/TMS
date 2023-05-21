class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_to user
  end

  def destroy
    followed_id, follower_id = params[:followed_data].split('|').map(&:to_i)

    relationship = Relationship.find_by(followed_id: followed_id, follower_id: follower_id)
    user = Relationship.find(relationship.id).followed
    current_user.unfollow(user)
    redirect_to user
  end
end
