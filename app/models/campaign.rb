class Campaign < ActiveRecord::Base
 #before_validation :validate_selected_list
 validates :subject,:body_text, presence: true

 has_many :campaign_lists, :dependent => :destroy
 has_many :lists, :through => :campaign_lists

  
  #def validate_selected_list 
  
  #if list_ids == nil
   #  errors.add(:list_options, "não pode estar em branco")   
 #end
 #end
 
end
