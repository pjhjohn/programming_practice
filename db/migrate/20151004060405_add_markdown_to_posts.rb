class AddMarkdownToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :rendered, :string
  end
end
