class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_article, only: %i[show update destroy]

  def index
    @articles = Article.all
    render json: @articles
  end
  def show
    @article = Article.find(params[:id])
    render json: @article
  end

  # POST /articles
  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      render json: @article, status: :created, location: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if current_user == @article.user
      if @article.update(article_params)
        render json: @article
      else
        render json: @article.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'You are not allowed to update this article!' }, status: :unauthorized
    end
  end

  # DELETE /articles/1
  def destroy
    if current_user == @article.user
      @article.destroy
    else
      render json: { error: 'You are not allowed to destroy this article!' }, status: :unauthorized
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
