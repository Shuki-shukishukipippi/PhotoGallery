class PhotosController < ApplicationController
  before_action :authenticate_user!
  before_action :find_photo, only: [:show, :edit, :update, :destroy]
  
  def index
    @photos = Photo.all
  end

  def show
  end

  def edit
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.create(photo_params)
    @photo.user_id = current_user.id 
    if @photo.save!
      redirect_to root_path
    else
      render :new
    end    
  end

  def update
    if @photo.update!(photo_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if @photo.destroy!
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def find_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:title, :body, :image, :remove_image)
  end
end
