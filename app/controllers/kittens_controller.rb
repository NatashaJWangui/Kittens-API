class KittensController < ApplicationController
  before_action :set_kitten, only: [ :show, :edit, :update, :destroy ]
  rescue_from ActiveRecord::RecordNotFound, with: :kitten_not_found

  def index
    @kittens = Kitten.all.order(:name)

    respond_to do |format|
      format.html # renders index.html.erb
      format.json {
        render json: @kittens.as_json(
          only: [ :id, :name, :age, :cuteness, :softness, :image_url ],
          methods: [ :age_description, :cuteness_level, :softness_level ]
        )
      }
    end
  end

  def show
    respond_to do |format|
      format.html # renders show.html.erb
      format.json {
        render json: @kitten.as_json(
          only: [ :id, :name, :age, :cuteness, :softness, :image_url, :created_at ],
          methods: [ :age_description, :cuteness_level, :softness_level ]
        )
      }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.save
      redirect_to @kitten, notice: "🎉 Kitten was successfully created!"
    else
      flash.now[:alert] = "😿 Oops! There were some errors with your kitten."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @kitten.update(kitten_params)
      redirect_to @kitten, notice: "✨ Kitten was successfully updated!"
    else
      flash.now[:alert] = "😿 Oops! There were some errors updating your kitten."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @kitten.destroy
    redirect_to kittens_path, notice: "💔 Kitten has been removed (hopefully to a good home!)."
  end

  def api
    # Just renders the API documentation page
  end

  private

  def set_kitten
    @kitten = Kitten.find(params[:id])
  end

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness, :image_url)
  end

  def kitten_not_found
    respond_to do |format|
      format.html { redirect_to kittens_path, alert: "Kitten not found!" }
      format.json { render json: { error: "Kitten not found" }, status: :not_found }
    end
  end
end
