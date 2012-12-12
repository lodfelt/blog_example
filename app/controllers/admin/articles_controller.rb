class Admin::ArticlesController < ApplicationController
  load_and_authorize_resource :article, except: [:index, :create, :new]
  before_filter :authenticate_user!, except: [:index, :show]

  layout 'admin'

  def index
    authorize! :access, :admin
    @articles = Article.published.all(include: :user)
    @drafts = Article.drafts.all
    @tags = Tag.all
  end

  def show
    authorize! :access, :admin
    respond_to do |format|
      format.html
      format.json { render json: @article }
    end
  end

  def new
    @article = Article.new
    respond_to do |format|
      format.html
      format.js
      format.json { render json: @article }
    end
  end

  def edit
  end

  def create
    @article = Article.new(params[:article])
    authorize! :create, @article
    @article.user_id = current_user.id
    respond_to do |format|
      if @article.save
        format.html { redirect_to admin_articles_path, notice: 'Article was successfully created.' }
        format.js
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update_attributes(params[:article])
        expire_fragment "recent_posts"
        format.html { redirect_to admin_articles_path, notice: 'Article was successfully updated.' }
        format.json { render json: @article, status: :ok, location: @article}
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to admin_articles_path }
      format.js
      format.json { head :no_content }
    end
  end
end
