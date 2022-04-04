class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.timestamp :date
      t.string :place
      t.string :description
      t.string :opening
      t.string :closing
      t.string :sender
      t.string :sender_status

      t.timestamps
    end
  end
end
