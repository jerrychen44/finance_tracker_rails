class User::RegistrationsController < Devise::RegistrationsController
  #[Jerry] by default, User::RegistrationsController inherant all Devise::RegistrationsController
  #if something can not found here, then it will look up the parent Devise::RegistrationsController
  #so , look up the User here, then find Devise.
  before_filter :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    #[Jerry]
    #.for is no longer herer. change to .permit
    #devise_parameter_sanitizer.for(:sign_up).push(:first_name, :last_name)
    #devise_parameter_sanitizer.for(:account_update).push(:first_name, :last_name)

    #adive by the Q&A in other people
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :email])
  end

end
