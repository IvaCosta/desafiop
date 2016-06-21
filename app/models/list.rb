class List < ActiveRecord::Base
  validates :name, presence: true
  
   has_many :subscribers, :dependent => :destroy
   
   has_many :campaign_lists, :dependent => :destroy
   has_many :campaigns, :through => :campaign_lists
end
