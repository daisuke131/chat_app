# frozen_string_literal: true

class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :room_name, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
