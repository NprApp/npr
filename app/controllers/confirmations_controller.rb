class ConfirmationsController < Devise::ConfirmationsController
  skip_before_filter :authenticate_user!, only: [:show]
end
