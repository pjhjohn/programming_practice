class ReplyController < ApplicationController
  before_filter :signin_required
  def create
    reply2create = Reply.new
    reply2create.user_id = session[:user_id]
    reply2create.post_id = params[:id]
    reply2create.body = params[:body]
    reply2create.save
    redirect_to "/board/page/0/#{params[:id]}"
  end
end
