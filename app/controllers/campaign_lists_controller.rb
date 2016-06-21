class CampaignListsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    @campaign_lists = CampaignList.all
  end

  def show
    @campaign_list = CampaignList.find(params[:id])
  end

  def create
   if params[:list_ids]
     lists = eval(params[:list_ids])
   end
   lists.each do |l|
     CampaignList.create(:campaign_id => 1, :list_id =>l)
   end
    redirect_to back
  end

  def update
    campaign_list = CampaignList.find(params[:id])
    campaign_list.update_attributes(params.require(:campaign_list).permit(:campaign_id, :list_id))
    head :no_content
  end

  def destroy
    campaign_list = CampaignList.find(params[:id])
    campaign.destroy
    head :no_content
  end


end
