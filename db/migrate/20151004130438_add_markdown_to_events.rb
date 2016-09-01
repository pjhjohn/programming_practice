class AddMarkdownToEvents < ActiveRecord::Migration
  def change
    add_column :events, :rendered, :string
  end
end
