require 'fileutils'

class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = current_user.pictures.all
  end

  # GET /pictures/new
  def new
    @picture = Picture.new
    @picture.user = current_user
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = Picture.new(picture_params)
    @picture.user = current_user

    # Very simple upload
    filename = params[:picture][:filename]

    upload_directory = Rails.root.join('public', 'uploads')
    FileUtils.mkdir_p(upload_directory) unless File.exists?(upload_directory)

    File.open(Rails.root.join('public', 'uploads', filename.original_filename), 'wb') do |file|
      file.write(filename.read)
      @picture.filename = filename.original_filename
    end

    if @picture.save
      flash[:success] = "Your picture was successfully uploaded"
      redirect_to pictures_path
    else
      render :new
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    redirect_to pictures_path, notice: 'Picture was successfully destroyed'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_picture
    @picture = Picture.where(id: params[:id], user: current_user)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def picture_params
    params.require(:picture).permit(:title, :filename)
  end

end