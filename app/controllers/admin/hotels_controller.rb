class Admin::HotelsController < Admin::BaseController
  def index
        @hotels = current_admin_user.hotels.page(params[:page]).per(2)    
    end 

    def new
        @hotel = current_admin_user.hotels.build
    end    

    def create
        @hotel = current_admin_user.hotels.build(permitted_params)

        if @hotel.save
          redirect_to admin_hotels_path
        else
          render :new
        end          
    end    

    def edit
    end    

    def update
        if hotel.update(permitted_params)
          redirect_to admin_hotels_path
        else
          render :edit
        end          
    end    

    def destroy
        hotel.destroy

        redirect_to admin_hotels_path 
    end    


    private

    def hotel
      @hotel ||= current_admin_user.hotels.find(params[:id])     
    end
    helper_method :hotel

    def permitted_params
      params.require(:hotel).permit(:title, :description)
    end  
end    