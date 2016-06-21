class CreateCampaignLists < ActiveRecord::Migration
  def change
    create_table :campaign_lists do |t|
      t.references :campaign
      t.references :list

      t.timestamps null: false
    end
	 add_index :campaign_lists, :campaign_id
	 add_index :campaign_lists, :list_id
  end
end
