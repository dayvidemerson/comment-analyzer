class Importer::UsersController < ApplicationController
  before_action :set_importer, only: %i[ show ]

  # GET /importer/users
  def index
    @importer_users = Importer::User.all

    render json: @importer_users
  end

  # GET /importer/users/1
  def show
    render json: @importer
  end

  # POST /importer/users
  def create
    @importer = Importer::User.new(key: params[:username])

    if @importer.save
      render json: @importer, status: :created, location: @importer
    else
      render json: @importer.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_importer
      @importer = Importer::User.find(params.expect(:id))
    end
end
