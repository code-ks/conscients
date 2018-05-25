# frozen_string_literal: true

class Admin::BlogPostsController < ApplicationController
  layout 'admin'

  before_action :set_blog_post, only: %i[show edit update destroy]
  before_action :authenticate_admin_user!

  def index
    @blog_posts = BlogPost.all
  end

  def show; end

  def new
    @blog_post = BlogPost.new
  end

  def edit; end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.save
      redirect_to admin_blog_post_path(@blog_post)
    else
      render :new
    end
  end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to admin_blog_post_path(@blog_post)
    else
      render :edit
    end
  end

  def destroy
    @blog_post.destroy
    redirect_to admin_blog_posts_path
  end

  private

  def set_blog_post
    @blog_post = BlogPost.find(params[:id])
  end

  def blog_post_params
    params.require(:blog_post).permit(:content_fr, :content_en, :position, :main_image,
                                      :seo_title_fr, :seo_title_en, :meta_description_fr,
                                      :meta_description_en, :published_fr, :published_en)
  end
end
