# -*- encoding : utf-8 -*-
class AddIdentityUrl < ActiveRecord::Migration
  def self.up
    add_column :users, :identity_url, :string
  end

  def self.down
    remove_column :users, :identity_url
  end
end
