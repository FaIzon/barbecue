class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  # настройка для работы девайза при правке профиля юзера
  before_action :configure_permitted_parameters, if: :devise_controller?

  # хелпер метод, доступный во вьюхах
  helper_method :current_user_can_edit?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: [:password, :password_confirmation, :current_password]
    )
  end

  # показывает может ли текущий залогиненный юзер править этот эвент
 # обновили метод - теперь на вход принимаем event, или "дочерние" объекты
  def current_user_can_edit?(model)
    user_signed_in? &&
      (model.user == current_user || # если у модели есть юзер и он залогиненный
        # пробуем у модели взять .event и если он есть, проверяем его юзера
        (model.try(:event).present? && model.event.user == current_user))
  end
end
