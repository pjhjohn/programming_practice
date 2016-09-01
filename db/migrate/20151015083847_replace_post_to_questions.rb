class ReplacePostToQuestions < ActiveRecord::Migration
  def change
    rename_column :reply_questions, :post_id, :questions_id
  end
end
