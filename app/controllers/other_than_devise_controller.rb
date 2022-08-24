class OtherThanDeviseController < ApplicationController

  before_action :authenticate_user!, only: [:account, :edit, :update]

  def account
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.name = params[:name]
    @user.introduction = params[:introduction]

    if params[:name].empty? || params[:introduction].empty?
      flash.now[:alert] = "名前と自己紹介は必須です。"
      render("other_than_devise/edit")
    else
      if params[:image_name]
        @user.image_name = "#{@user.id}.jpg"
        image = params[:image_name]
        File.binwrite("public/user_images/#{@user.image_name}", image.read)
      end
      @user.save
      flash[:notice] = "ユーザープロフィールの更新に成功しました。"
      redirect_to("/users/profile")
    end
  end
end
