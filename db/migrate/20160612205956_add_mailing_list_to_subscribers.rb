class AddMailingListToSubscribers < ActiveRecord::Migration
  def change
    add_column :subscribers, :mailing_list_id, :integer
	add_index  :subscribers,  :mailing_list_id
  end
end
