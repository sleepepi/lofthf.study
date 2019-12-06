class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_editor!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_article_or_redirect, only: [:show, :edit, :update, :destroy]

  layout "layouts/full_page_sidebar"

  # GET /articles
  def index
    scope = articles.search_any_order(params[:search])
    @articles = scope_order(scope).page(params[:page]).per(10)
  end

  # # GET /articles/1
  # def show
  # end

  # GET /articles/new
  def new
    @article = current_user.articles.new
  end

  # # GET /articles/1/edit
  # def edit
  # end

  # POST /articles
  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      redirect_to @article, notice: "Article was successfully created."
    else
      render :new
    end
  end

  # PATCH /articles/1
  def update
    if @article.update(article_params)
      redirect_to @article, notice: "Article was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
    redirect_to articles_path, notice: "Article was successfully deleted."
  end

  private

  def articles
    if current_user.editor?
      Article.current
    else
      Article.current.published
    end
  end

  def find_article_or_redirect
    @article = articles.find_by_param(params[:id])
    empty_response_or_root_path(articles_path) unless @article
  end

  def article_params
    params[:article] ||= { blank: "1" }
    parse_date_if_key_present(:article, :publish_date)
    params.require(:article).permit(
      :title, :slug, :description, :publish_date, :published
    )
  end

  def scope_order(scope)
    scope.order(Arel.sql(Article::ORDERS[params[:order]] || Article::DEFAULT_ORDER))
  end
end
