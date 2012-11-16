class CommentsController < ApplicationController
  load_and_authorize_resource :article
  load_and_authorize_resource :comment, except: [:create]


  def create
    @comment = @article.comments.build(params[:comment])
    respond_to do |format|
      if @comment.save
        format.html { redirect_to(@article, notice: t(:'comments.created_notice')) }
        format.json  { render json: @article, status: :created, location: @article }
      else
        format.html { redirect_to(@article, notice: t(:'.comments.not_created')) }
        format.json  { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(@article, :notice => 'Comment was successfully deleted.') }
      format.xml  { head :ok }
    end
  end
end
