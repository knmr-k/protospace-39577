class UsersController < ApplicationController
  def show
    @users = User.find(params[:id])
    @prototypes = @users.prototypes
  end
end
