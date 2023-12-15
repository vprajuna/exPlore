class PlacesController < ApplicationController
  # before_action :set_place, only: %i[ show edit update destroy ]
  before_action :set_globals

  # GET /places or /places.json
  def index
    liked_places = []
    @likes.each do |like_id|
      liked_places << Place.find(like_id)
    end

    @places = MergeSort.merge_sort_by_user_votes(liked_places)

  end

  # GET /places/1 or /places/1.json
  def show
    @place = @places[@position]
    @image = get_image_path
  end

  def love
    @place = Place.find(params[:id])
    @count = @places.count

    user_votes = @place.user_votes + 1
    @place.update_attribute(:user_votes, user_votes)

    @position += 1
    @likes << @place.id

    session[:position] = @position
    session[:likes] = @likes


    redirect_to place_path(@place)
  end

  def hate
    @place = Place.find(params[:id])

    user_votes = @place.user_votes - 1
    @place.update_attribute(:user_votes, user_votes)

    @position += 1
    session[:position] = @position

    redirect_to place_path(@place)
  end

  # GET /places/new
  def new
    @place = Place.new
  end

  # GET /places/1/edit
  def edit
  end

  # POST /places or /places.json
  def create
    @place = Place.new(place_params)

    respond_to do |format|
      if @place.save
        format.html { redirect_to place_url(@place), notice: "Place was successfully created." }
        format.json { render :show, status: :created, location: @place }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /places/1 or /places/1.json
  def update
    respond_to do |format|
      if @place.update(place_params)
        format.html { redirect_to place_url(@place), notice: "Place was successfully updated." }
        format.json { render :show, status: :ok, location: @place }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1 or /places/1.json
  def destroy
    @place.destroy

    respond_to do |format|
      format.html { redirect_to places_url, notice: "Place was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def place_params
      params.require(:place).permit(:name)
    end

    def get_image_path
      images = Dir.glob("app/assets/images/*.jpg")
      image_path = images.sample
      return image_path.sub("app/assets/images/", "")
    end

    def set_globals
      @places ||= BucketSort.call_sort(Place.where(state: current_user.state).first(150))
      @position ||= session[:position] || 0
      @likes ||= session[:likes] || []
    end

end
