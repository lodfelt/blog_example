class UsersController < ApplicationController

  layout "public"
  load_resource :user

  def show
    @profile = @user.profile
    @user_links = @profile.links.split(" ") unless @profile.links.blank?
    @recent_posts = @user.articles.limit(3)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def update
    authorize! :update, @user
    respond_to do |format|
      if @user.update_attributes(params[:user])
        expire_fragment "user_profile"
        format.html { redirect_to user_path(@user), notice: t(:'users.profile_updated') }
        format.json { head :no_content }
      else
        format.html { render action: "show" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  protected

  def set_ariane
    super
    user = User.find(params[:id])
    ariane.add user.name, user_path(user)
  end
end
