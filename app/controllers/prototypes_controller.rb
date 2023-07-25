class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index, :create, :edit, :update, :destroy]

  def index
    @prototype = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end
  
  def create
    @prototype = Prototype.create(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    #コメント表示用
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])

    #編集対象のユーザーIDとカレントユーザーIDが違う場合はリダイレクト
    unless @prototype.user_id == current_user.id
      redirect_to action: :index
    end
  end

  def update
    @prototype = Prototype.find(params[:id])

    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end


  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
end
