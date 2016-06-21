require 'rest-client'
class CampaignsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user!

  def index
    @campaigns = if params[:keywords]
                 Campaign.where('subject ilike ?',"%#{params[:keywords]}%")
               else
                  Campaign.all
               end
  end

  def show
    @campaign = Campaign.find(params[:id])
  end

  def create
    @campaign = Campaign.new(params.require(:campaign).permit(:subject, :body_text))
    @campaign.save
    if params[:list_ids]
      lists = eval(params[:list_ids])
      lists.each do |l|
        CampaignList.create(:campaign_id => @campaign.id, :list_id =>l)
      end
    end
    if params[:send]
       @subscribers = nil
       @lists = @campaign.lists
       @lists.each do |l|
          @subscribers = l.subscribers.map(&:email)
        end
        subscribers = @subscribers.map(&:inspect).join(', ')
        send_email(subscribers, params[:subject],params[:body_text])
    end

    render 'show', status: 201
  end

  def update
    campaign = Campaign.find(params[:id])
    campaign.update_attributes(params.require(:campaign).permit(:subject, :body_text))
    head :no_content
  end

  def destroy
    campaign = Campaign.find(params[:id])
    campaign.destroy
    head :no_content
  end

  private
  def send_email(subscribers, subject, text)
    RestClient.post "https://api:key-fb6959b8d265475d06d96f139262b1ef"\
     "@api.mailgun.net/v3/sandbox77d066d127a84a72a0727f80a75b1d76.mailgun.org/messages",
     :from => "Desafio P. <mailgun@sandbox77d066d127a84a72a0727f80a75b1d76.mailgun.org>",
     :to => subscribers,
     :subject => subject,
     :text => text
   end


end
