class CampaignList < ActiveRecord::Base
  belongs_to :list
  belongs_to :campaign
end
