# frozen_string_literal: true

class CreateStoreUrls < ActiveRecord::Migration[7.1]
  def change
    create_table :store_urls do |t|
      t.string :url, null: false
      t.string :tracking_code
      t.references :client, foreign_key: true
      t.timestamps
    end

    add_index :store_urls, :tracking_code, unique: true
  end
end
