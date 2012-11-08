class ArticlesController < ApplicationController
  load_and_authorize_resource :article, except: [:index, :create, :new]
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @articles = Article.published.all(include: :user)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end
end
