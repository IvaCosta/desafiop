class AddFieldToSubscribes < ActiveRecord::Migration
  def change
    add_column :subscribers, :name, :string
	add_column :subscribers, :email, :string, :null => false, :default => ""
  end     
end
