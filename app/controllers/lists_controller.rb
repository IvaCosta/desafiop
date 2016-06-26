class ListsController < ApplicationController
   skip_before_filter :verify_authenticity_token
   before_filter :authenticate_user!

  def index
    if params[:keywords]
             @lists = List.where('name ilike ?',"%#{params[:keywords]}%")
               elsif params[:campaignId]
			   @campaign = Campaign.find(params[:campaignId])
			   @lists = @campaign.lists
			   else
             @lists =  List.all
               end
  end

  def show
    @list = List.find(params[:id])
	  @subscribers = @list.subscribers
  end

  def create
    @list = List.new(params.require(:list).permit(:name,:email))
    @list.save
    render 'show', status: 201
  end

  def update
    list = List.find(params[:id])
    list.update_attributes(params.require(:list).permit(:name,:email))
    head :no_content
  end

  def destroy
    list = List.find(params[:id])
    list.destroy
    head :no_content
  end
end
