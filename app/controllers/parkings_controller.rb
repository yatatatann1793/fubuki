class ParkingsController < ApplicationController
  before_action :set_parking, only: [:show, :edit, :update, :destroy]

  # GET /parkings
  # GET /parkings.json
  def index
    @parkings = Parking.all
  end

  # GET /parkings/1
  # GET /parkings/1.json
  def show
  end

  # GET /parkings/new
  def new
    @parking = Parking.new
  end

  # GET /parkings/1/edit
  def edit
  end

  # POST /parkings
  # POST /parkings.json
  def create
    @parking = Parking.new(parking_params)

    respond_to do |format|
      if @parking.save
        format.html { redirect_to @parking, notice: 'Parking was successfully created.' }
        format.json { render action: 'show', status: :created, location: @parking }
      else
        format.html { render action: 'new' }
        format.json { render json: @parking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parkings/1
  # PATCH/PUT /parkings/1.json
  def update
    respond_to do |format|
      if @parking.update(parking_params)
        format.html { redirect_to @parking, notice: 'Parking was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @parking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parkings/1
  # DELETE /parkings/1.json
  def destroy
    @parking.destroy
    respond_to do |format|
      format.html { redirect_to parkings_url }
      format.json { head :no_content }
    end
  end

  private

  def set_parking
    @parking = Parking.includes(:allow_times, :deny_dates).find(params[:id])
  end

  def parking_params
    params.require(:parking).permit(:name,
                                    :address,
                                    :user_id,
                                    :memo,
                                    :photo,
                                    :latitude,
                                    :longitude,
                                    {
                                      allow_times_attributes: [
                                        :id,
                                        :weekday,
                                        :start_time,
                                        :end_time,
                                        :_destroy
                                      ],
                                      deny_dates_attributes: [
                                        :id,
                                        :date,
                                        :_destroy
                                      ]
                                    })
  end
end
