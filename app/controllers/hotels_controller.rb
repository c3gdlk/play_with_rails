class HotelsController < ApplicationController

    def index
        @hotels = Hotel.page(params[:page]).per(2)    
    end 

    def new
        @hotel = Hotel.new
    end    

    def create
        @hotel = Hotel.new(permitted_params)

        if @hotel.save
          redirect_to hotels_path
        else
          render :new
        end          
    end    

    def edit
    end    

    def update
        if hotel.update(permitted_params)
          redirect_to hotels_path
        else
          render :edit
        end          
    end    

    def destroy
        hotel.destroy

        redirect_to hotels_path 
    end    


    private

    def hotel
      @hotel ||= Hotel.find(params[:id])     
    end
    helper_method :hotel

    def permitted_params
      params.require(:hotel).permit(:title, :description)
    end    

end    