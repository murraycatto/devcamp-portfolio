class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :toggel_status, :destroy]
  layout "blog"
  access all: [:show, :index], user: {except: [:destroy, :new, :create, :update, :edit]}, site_admin: :all

  def index
    @blogs = Blog.page(params[:page]).per(5)
    @page_title = "My Portfolio Blog"
  end

  def show
    @page_title = @blog.title
    @seo_keywords = @blog.body
  end

  def new
    @blog = Blog.new
  end

  def edit
  end

  def create
    @blog = Blog.new(blog_params)
    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def toggel_status
    if @blog.draft?
      @blog.published!
    elsif @blog.published?
      @blog.draft!
    end
    redirect_to blogs_url, notice: 'Blog status updated.'
  end

  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
    end
  end

  private
    def set_blog
      @blog = Blog.friendly.find(params[:id])
    end

    def blog_params
      params.require(:blog).permit(:title, :body)
    end
end
