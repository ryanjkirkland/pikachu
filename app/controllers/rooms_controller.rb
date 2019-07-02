class RoomsController < ApplicationController
  
  before_action :set_room, except: [:index, :new, :create, :delete_image]
  before_action :authenticate_user!, except: [:show]

  def index
    @rooms = current_user.rooms
  end

  def new
    @room = current_user.rooms.build
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to listing_room_path(@room), notice: "Saved..."
    else
      flash[:alert] = "Please complete all fields"
      render :new
    end
  end

  def show
  end

  def listing
  end

  def pricing
  end

  def description
  end

  def photo_upload
  end

  def amenities
  end

  def location
  end

  def delete_image
    @images = ActiveStorage::Attachment.find(params[:id])
    @images.purge
    redirect_back(fallback_location: request.referer)
  end

  def update

    new_params = room_params
    new_params = room_params.merge(active: true) if is_ready_room
    
    if @room.update(new_params)
      flash[:notice] = "Saved"
    else
      flash[:alert] = "Something went wrong"
    end
    redirect_back(fallback_location: request.referer)
  end

  private
    def set_room
      @room = Room.find(params[:id])
    end

    def is_authorised
      redirect_to root_path, alert: "You don't have permission" unless current_user.id == @room.user_id
    end

    def is_ready_room
      !@room.active && !@room.price.blank? && !@room.listing_name.blank? && !@room.images.blank? && !@room.address.blank?
    end

    def room_params
      params.require(:room).permit(:home_type, :room_type, :accomodate, :bed_room, :bath_room, :listing_name, :summary, :address, :is_tv, :is_kitchen, :is_air, :is_heating, :is_internet, :price, :active, images: [])
    end
end
