class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show update destroy ]
  before_action :authenticate_user, except: %i[show index]

  # GET /articles
  def index
    @articles = Article.all

    render json: @articles
  end

  # GET /articles/1
  def show
    render json: @article
  end

  # POST /articles
  def create
    @article = Article.new(article_params)
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
      render json: { error: 'You are not allowed to update this article!' }, status: :unauthorized
    end
  end

  # DELETE /articles/1
  def destroy
    if current_user == @article.user
    @article.destroy!
    else
      render json: { error: 'You are not allowed to destroy this article!' }, status: :unauthorized
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content)
    end
end