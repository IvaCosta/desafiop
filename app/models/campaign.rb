class Campaign < ActiveRecord::Base
 validates :subject,:body_text, presence: true

 has_many :campaign_lists, :dependent => :destroy
 has_many :lists, :through => :campaign_lists

 
end
