class ReplyQuestionsController < ApplicationController
  before_filter :signin_required
  def create
    pagenum = ( Question.all.count - params[:id].to_i ) / 10 + 1
    unless session[:user_id].nil? or params[:id].nil?
      reply2create = ReplyQuestion.new
      reply2create.user_id = session[:user_id]
      reply2create.question_id = params[:id]
      reply2create.body = params[:body]
      reply2create.save
      redirect_to "/questions/read/" + pagenum.to_s + "/#{params[:id]}", notice: "댓글이 작성되었습니다"
    else
      redirect_to "/questions/read/" + pagenum.to_s + "/#{params[:id]}", alert: "댓글을 등록할 수 없습니다"
    end
  end
  
  def delete
    if params[:id].nil?
      redirect_to "/"
    end
    reply = ReplyQuestion.find_by_id(params[:id])
    if reply.present? 
      if session[:user_id] == reply.user.id
        post_id = reply.post.id
        reply.destroy
        pagenum = ( Question.all.count - post_id ) / 10 + 1
        redirect_to "/questions/read/" + pagenum.to_s + "/" + post_id.to_s, notice: "댓글이 삭제되었습니다"
      else
        redirect_to "/questions/read/" + pagenum.to_s + "/" + post_id.to_s, alert: "댓글을 삭제 할 수 없습니다"
      end
    else
        redirect_to "/"
    end
  end
end
