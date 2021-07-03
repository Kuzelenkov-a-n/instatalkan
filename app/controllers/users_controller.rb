class UsersController < ApplicationController
  def destroy
    current_user.destroy
  end
end
