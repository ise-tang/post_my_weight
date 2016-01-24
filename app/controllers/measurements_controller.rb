class MeasurementsController < BaseController
  def index
    @measurements = Measurement.where(user_id: current_user.id).order('updated_at DESC').page(params[:page]).per(10)
  end

  def edit
    @measurement = Measurement.find(params['id'])
  end

  def update
    @measurement = Measurement.find(params['id'])

    attr = measurement_params
    if @measurement.update_attributes(attr)
      redirect_to(edit_measurement_url(@measurement), :notice => '体重修正を行いました')
    else
      render action: :edit
    end
  end

  def measurement_params
    params.require(:measurement).permit(:weight, :body_fat_percentage)
  end
end
