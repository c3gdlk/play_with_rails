class RoomsController < ApplicationController
    def index
        @rooms = hotel.rooms    
    end 

    def new
        @room = hotel.rooms.build
    end    

    def create
        @room = hotel.rooms.build(permitted_params)

        if @room.save
          redirect_to hotel_rooms_path(hotel)
        else
          render :new
        end          
    end    

    def edit
    end    

    def update
        if room.update(permitted_params)
          redirect_to hotel_rooms_path(hotel)
        else
          render :edit
        end          
    end    

    def destroy
        room.destroy

        redirect_to hotel_rooms_path(hotel) 
    end 

    private

    def hotel
      @hotel ||= Hotel.find(params[:hotel_id])     
    end
    helper_method :hotel 

    def room
      @room ||= hotel.rooms.find(params[:id])     
    end
    helper_method :room

    def permitted_params
      params.require(:room).permit(:title)
    end    
end    