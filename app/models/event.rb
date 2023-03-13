class Event < ApplicationRecord
    
    validates :title,presence:true
  　validates :content,presence:true,length:{maximum:200}
  
    def create
        @event = event.new
    end
    def show
        @event = Event.find(paramas[:id])
    end
    
    private
    
    def event_params
     params.require(:event).permit(:title,:content)
    end    
end
