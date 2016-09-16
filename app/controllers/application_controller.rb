class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  #[Jerry] means all controller action(index, new, edit...) in this app need
  #go the  authenticate_user first!
  #which means all need to be login or someting authentication
  before_action :authenticate_user!
end
