class SubscribersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user!, :load_associations
   

  def index
    @subscribers =  if params[:keywords]
                 @list.subscribers.where('name ilike ?',"%#{params[:keywords]}%")
               else
                  @list.subscribers.all
               end
  end


  def show
    @subscriber = @list.subscribers.find(params[:id])
  end

  def create
    @subscriber = @list.subscribers.new(params.require(:subscriber).permit(:name,:email,:list_id))
    @subscriber.save
    render 'show', status: 201
  end

  def update
    subscriber = @list.subscribers.find(params[:id])
    subscriber.update_attributes(params.require(:subscriber).permit(:name,:email,:list_id))
    head :no_content
  end

  def destroy
    subscriber =  @list.subscribers.find(params[:id])
    subscriber.destroy
    head :no_content
  end


  def load_associations
	  @list = List.find(params[:list_id])
    end
end
