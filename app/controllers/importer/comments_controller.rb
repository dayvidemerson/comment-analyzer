class Importer::CommentsController < ApplicationController
  # GET /importer/comments
  def index
    @importer_comments = Importer::Comment.all

    render json: @importer_comments
  end
end
