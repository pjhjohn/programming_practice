class ReplaceQuestionsToQuestion < ActiveRecord::Migration
  def change
    rename_column :reply_questions, :questions_id, :question_id
  end
end
