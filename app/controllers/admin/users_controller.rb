class Admin::UsersController < ApplicationController

  load_and_authorize_resource :user, except: [:create]

  layout 'admin'

  def show
    respond_to do |format|
      format.html { render partial: "admin/users/full_name", locals: { user: @user } }
      format.js
    end
  end

  def create
    @user = User.new(params[:user])
    authorize! :create, @user
    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_articles_path, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { redirect_to admin_articles_path, notice: @article.errors.full_messages.join(", ") }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize! :update, @user
    respond_to do |format|
      if @user.update_attributes(params[:user])
        expire_fragment "user_profile"
        format.html { redirect_to admin_articles_path, notice: t(:'users.profile_updated') }
        format.json { respond_with_bip(@user) }
      else
        format.html { render action: "show" }
        format.json { respond_with_bip(@user) }
      end
    end
  end

  def destroy
    authorize! :delete, @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
end
