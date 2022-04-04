class CreateRecipients < ActiveRecord::Migration[7.0]
  def change
    create_table :recipients do |t|
      t.string :name
      t.string :converted_name_for_link
      t.integer :event_id

      t.timestamps
    end
  end
end
