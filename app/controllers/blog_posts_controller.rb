# frozen_string_literal: true

class BlogPostsController < ApplicationController
  def index
    @blog_posts = BlogPost.send("published_#{I18n.locale}").page(params[:page])
  end

  def show
    @blog_post = BlogPost.find(params[:id])
  end
end
