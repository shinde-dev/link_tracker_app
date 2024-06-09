# frozen_string_literal: true

class CreateUrlTrackings < ActiveRecord::Migration[7.1]
  def change
    create_table :url_trackings do |t|
      # TODO: : Change to jsonb with postgres
      t.json :metadata, default: {}
      t.references :store_url, foreign_key: true
      t.timestamps
    end
  end
end
