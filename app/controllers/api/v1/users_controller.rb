class Api::V1::UsersController < Api::V1::BaseController
  # tested all the api in postman, should work lol
  skip_before_action :verify_authenticity_token
  before_action :find_user, only: [:show, :update]

  def show
  end

  def update
    # frontend should set the validation(the edit button), so no logic here
    if @user.update(user_params)
      # return created object, for validation or added status
      render :show
    else
      # return error message
      render_error
    end
  end

  private

  def user_params
    params.require(:user).permit(:customized_request, :status, :start_date, :end_date, :destination, :number_of_passengers, :passenger_identifications, :total_price, :start_time, :end_time)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def render_error
    render json: { errors: @user.errors.full_messages },
      status: :unprocessable_entity
  end
end