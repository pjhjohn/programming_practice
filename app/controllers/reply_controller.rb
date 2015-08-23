class ReplyController < ApplicationController
  before_filter :signin_required
  def create
    unless session[:user_id].nil? or params[:id].nil?
      reply2create = Reply.new
      reply2create.user_id = session[:user_id]
      reply2create.post_id = params[:id]
      reply2create.body = params[:body]
      reply2create.save
      redirect_to "/board/read/0/#{params[:id]}", notice: "댓글이 작성되었습니다"
    else
      redirect_to "/board/read/0/#{params[:id]}", alert: "댓글을 등록할 수 없습니다."
    end
  end
end
