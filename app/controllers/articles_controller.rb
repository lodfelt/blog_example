class ArticlesController < ApplicationController
  load_and_authorize_resource :article, except: [:index, :create, :new]
  before_filter :authenticate_user!, except: [:index, :show]
  layout "public"

  def index
    @articles = Article.search(params[:search]).paginate(per_page: 3, page: params[:page])
    respond_to do |format|
      format.html {
        if request.xhr?
          render partial: "articles/articles", locals: {articles: @articles}
        end
        # else render index.html as usual
      }
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
