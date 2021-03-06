class GooglesController < ApplicationController
  def create
    google_user = Google.where(uid: request.env["omniauth.auth"][:uid])
    if google_user.count == 1
      session[:user_id] = google_user.first.user_id
      flash[:notice] = "Signed in with Google!"
      redirect_to root_path
    else
      new_user = User.create(auth_type: :google, registered: 'true')
      new_user.googles.create(uid: request.env["omniauth.auth"][:uid], name: request.env["omniauth.auth"][:info][:name])
      session[:user_id] = new_user.id
      flash[:notice] = "Signed in with Google!"
      redirect_to root_path
    end
    session[:username] = request.env["omniauth.auth"][:info][:name]
  end
end
