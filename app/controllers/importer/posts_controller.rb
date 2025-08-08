class Importer::PostsController < ApplicationController
  # GET /importer/posts
  def index
    @importer_posts = Importer::Post.all

    render json: @importer_posts
  end
end
