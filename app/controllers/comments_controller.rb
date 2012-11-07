class CommentsController < ApplicationController
  load_and_authorize_resource :comment, except: [:create]

  def edit
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(params[:comment])
    authorize! :create, @comment
    respond_to do |format|
      if @comment.save
        format.html { redirect_to(@article, :notice => 'Comment was successfully created.') }
        format.json  { render json: @article, :status => :created, location: @article }
      else
        format.html { redirect_to(@article, :notice =>
        'Comment could not be saved. Please fill in all fields')}
        format.json  { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # def update
  #   @article = @comment.article
  #   respond_to do |format|
  #     if @comment.update_attributes(params[:comment])
  #       format.html { redirect_to(@article, :notice => 'Comment was successfully updated.') }
  #       format.xml  { head :ok }
  #     else
  #       format.html { render :action => "edit" }
  #       format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

  def destroy
    @article = Article.find(params[:article_id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(@article, :notice => 'Comment was successfully deleted.') }
      format.xml  { head :ok }
    end
  end
end
