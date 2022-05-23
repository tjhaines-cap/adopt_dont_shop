class AdminSheltersController < ApplicationController

    def index
        @shelters = Shelter.order(name: :desc)
    end

end