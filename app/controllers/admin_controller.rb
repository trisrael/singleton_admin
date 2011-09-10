
module HS
  class AdminController < ::ApplicationController
    #Action which renders a simple form with a field for filling in a password
    def login
      @logged_in = hs_admin?
      @ids = HS::Admin.ids
    end
    
    #Check whether password was correct, if so redirect to root with flash success and set up a session
    #otherwise return to login_page with flash of unsuccessful message
    def create
      val = params[:pass]
      if HS::Admin.correct_pass?(val)
        hs_admin_login
        flash[:notice] = "Successfully logged in."
      else
        flash[:error] = "Invalid password supplied."
        render :login and return
      end
      
      redirect_to "/" #go to root if all is well
        
    end

    
    #end admin session
    def destroy
      hs_admin_logout
      flash[:notice] = "Successfully logged out."
      redirect_to "/"
    end
    
    
     def hs_admin_login
        HS::Admin.add sesh_id
      end

      def hs_admin_logout
        HS::Admin.remove sesh_id
      end  

      def hs_admin?
        HS::Admin.authenticated? sesh_id
      end

      private

      def sesh_id
        request.session_options[:id] 
      end
    
  end
end