class Admin::ArticleImagesController < ApplicationController

  load_and_authorize_resource :article
  load_and_authorize_resource :article_image, exept: [:create]

  def create
    @article_image = @article.images.create(params[:article_image])
    respond_to do |format|
      format.js { render :create }
    end
  end

  def update
    respond_to do |format|
      if @article_image.update_attributes(params[:article_image])
        expire_fragment "recent_posts"
        expire_fragment "all_articles"
        expire_fragment @article_image.article
        format.html { render partial: "admin/article_images/article_image", locals: {image: @article_image} }
        format.json { render json: @article, status: :ok, location: @article}
      else
        format.html { redirect_to admin_article_path(@article) }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article_image.destroy
    expire_fragment "recent_posts"
    expire_fragment "all_articles"
    expire_fragment @article_image.article
    respond_to do |format|
      format.html { head :ok }
      format.json { head :no_content }
    end
  end
end