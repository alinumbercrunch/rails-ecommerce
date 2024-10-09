class UserController < ApplicationController
layout "user"
before_action :authenticate_user!

  def index
  end
end
