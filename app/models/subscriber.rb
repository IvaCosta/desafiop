class Subscriber < ActiveRecord::Base
  validates :name, :email, :list_id, presence: true
  #validates_uniqueness_of :name
   #validates_uniqueness_of :email
   belongs_to :list
end
