class HomeController < ApplicationController
    def index
        redirect_to controller: :posts, action: :index
    end
end
