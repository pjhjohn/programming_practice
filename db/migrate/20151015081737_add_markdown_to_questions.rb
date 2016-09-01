class AddMarkdownToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :rendered, :string
  end
end
