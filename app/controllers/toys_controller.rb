class ToysController < ApplicationController
  # wrap_parameters false
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    toys = Toy.all
    render json: toys
  end

  def show
    toy = Toy.find_by(id: params[:id])
    render json: toy
  end

  def create
    toy = Toy.create!(toy_params)
  render json: toy, status: :created
rescue ActiveRecord::RecordInvalid => e
  render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def update
    toy = Toy.find_by(id: params[:id])
    toy.update(toy_params)
    render json: toy
  end

  def destroy
    toy = Toy.find_by(id: params[:id])
    toy.destroy
    head :no_content
  end

  private
  
  def find_toy
    Toy.find(params[:id])
  end

  def toy_params
    params.permit(:name, :image, :likes)
  end

  def render_not_found_response
    render json: { error: "Toy not found" }, status: :not_found
  end

end
