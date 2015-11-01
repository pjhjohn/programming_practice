class ReplyQuestion < ActiveRecord::Base
  belongs_to :questions
  belongs_to :user
end
