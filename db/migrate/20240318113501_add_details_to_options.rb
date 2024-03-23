# frozen_string_literal: true

class AddDetailsToOptions < ActiveRecord::Migration[7.2]
  def change
    add_column :options, :step, :integer
    add_column :options, :form_name, :string
  end
end
