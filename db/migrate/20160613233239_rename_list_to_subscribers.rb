class RenameListToSubscribers < ActiveRecord::Migration
  def change
    rename_column :subscribers, :mailing_list_id,  :list_id
  end
end
