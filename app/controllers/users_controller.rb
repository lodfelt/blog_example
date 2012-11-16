class UsersController < ApplicationController

  layout "public"
  load_and_authorize_resource :user

  def show
    @profile = @user.profile
    @user_links = @profile.links.split(" ") unless @profile.links.blank?
    @recent_posts = @user.articles(limit: 3)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to user_path(@user), notice: t(:'users.profile_updated') }
        format.json { head :no_content }
      else
        format.html { render action: "show" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
