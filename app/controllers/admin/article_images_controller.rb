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
    @article_image.update_main_article
    redirect_to edit_admin_article_path(@article), notice: t(:'admin.articles.updated_image')
  end

  def destroy
    @article_image.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
end