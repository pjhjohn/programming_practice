class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :body
      t.string :klass
      t.string :url, default: "/schedule/event"
      t.string :attachment_title
      t.string :attachment_url
      t.datetime :start
      t.datetime :finish
      t.timestamps null: false
    end
  end
end
