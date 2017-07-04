class Api::V1::HotelsController < Api::V1::BaseController
  before_action :authenticate_user!

  serialization_scope :view_context

  def index
    hotels = Hotel.all
    #render json: posts, status: 200, each_serializer: EnhancedPostSerializer
    render json: hotels, status: 200, each_serializer: AdminHotelSerializer
  end

  def create
        @hotel = current_admin_user.hotels.build(permitted_params)

        if @hotel.save
          render json: {success: true}, status: 201
        else
          render json: {success: false, errors: @hotel.errors.full_messages}, status: 422
        end          
    end 
end
