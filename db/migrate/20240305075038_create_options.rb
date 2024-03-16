# frozen_string_literal: true

class CreateOptions < ActiveRecord::Migration[7.2]
  def change
    create_table :options do |t|
      t.string :question
      t.json :options

      t.timestamps
    end
  end
end
