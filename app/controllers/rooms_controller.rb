class RoomsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :show, :posts]

  def index
    @rooms = Room.all.order(created_at: :desc)
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(
      name: params[:name],
      introduction: params[:introduction],
      price: params[:price],
      address: params[:address],
      user_id: current_user.id
    )

    if @room.save
      if params[:image_name]
        @room.image_name = "#{@room.id}.jpg"
        image = params[:image_name]
        File.binwrite("public/room_images/#{@room.image_name}", image.read)
      end

      @room.save
      flash[:notice] = "ルーム登録が完了しました。"
      redirect_to("/rooms/#{@room.id}")

    else
      flash.now[:alert] = "入力が足りない項目があります。"
      render("rooms/new")
    end
  end

  def show
    @room = Room.find_by(id: params[:id])
    session[:room_id] = @room.id
    @today = Date.today

    begin
      @reservation = Reservation.new(
      start_day: params[:start_day],
      finish_day: params[:finish_day],
      number_of_people: params[:number_of_people]
    )
    rescue
      @reservation = Reservation.new
    end
  end

  def posts
    @rooms = Room.where(user_id: current_user.id).order(created_at: :desc)
    @reservation = Reservation.new
  end

  def search
    @results = @q.result
  end

end
