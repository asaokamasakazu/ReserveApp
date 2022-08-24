class ReservationsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :show]

  def index
    @reservations = Reservation.all.order(created_at: :desc)
  end

  def new
    @reservation = Reservation.new(
      user_id: current_user.id,
      room_id: params[:room_id],
      start_day: params[:start_day],
      finish_day: params[:finish_day],
      number_of_people: params[:number_of_people]
    )

    @reservations_count = Reservation.all.count

    @room = Room.find_by(id: session[:room_id])
    @today = Date.today
    
    if @reservation.valid?
      if @reservation.start_day >= @reservation.finish_day
        flash.now[:alert] = "終了日は開始日より後にしてください。"
        render("rooms/show")
      else
        @stay_days = (@reservation.finish_day.to_date - @reservation.start_day.to_date).to_i
        @total_amount = @stay_days * @reservation.number_of_people * @room.price
      end
    else
      flash.now[:alert] = "開始日と終了日と人数を全て入力してください。"
      render("rooms/show")
    end
  end

  def show
    @reservation = Reservation.new(
      user_id: current_user.id,
      room_id: params[:room_id],
      start_day: params[:start_day],
      finish_day: params[:finish_day],
      total_amount: params[:total_amount]
    )

    @room = Room.find_by(id: session[:room_id])
    @today = Date.today

    if @reservation.save
      flash.now[:notice] = "お部屋の予約が完了しました。"
    else
      render("rooms/show")
    end
  end
end
