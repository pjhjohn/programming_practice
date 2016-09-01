class BoardController < ApplicationController
  @@markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, tables: true, fenced_code_blocks: true)

  before_filter :signin_required, except: [:index, :read]
  before_action -> {
    set_navbar_category "board"
  }
  def index
    params[:post_id] = nil
    params[:page_id] = 1
    read
    render :template => "board/read"
  end

  def new
  end

  def edit
    @post2edit = Post.find_by_id(params[:id])
    if is_owner_of @post2edit or user_admin?
      params[:user_id] = 0
      params[:user_id] = @post2edit.user.id unless @post2edit.user.nil?
    elsif params[:page_id].nil?
      redirect_to "/pp2015/board/read", alert: "이 게시물의 작성자가 아닙니다"
    elsif params[:id].nil?
      redirect_to "/pp2015/board/read/#{params[:page_id]}", alert: "이 게시물의 작성자가 아닙니다"
    else
      redirect_to "/pp2015/board/read/#{params[:page_id]}/#{params[:id]}", alert: "이 게시물의 작성자가 아닙니다"
    end
  end

  def remove
    if params[:id].nil?
      redirect_to :back
    elsif Post.find_by_id(params[:id]).nil?
      redirect_to :back
    else
      @post = Post.find_by_id(params[:id])
    end
  end

  def create
    post2create = Post.new
    post2create.user_id = session[:user_id]
    post2create.title = params[:title]
    post2create.body = params[:body]
    post2create.rendered = @@markdown.render(params[:body])
    post2create.is_announcement = User.find_by_id(session[:user_id]).is_admin unless User.find_by_id(session[:user_id]).nil?
    post2create.save
    redirect_to "/pp2015/board/read/0/#{post2create.id}"
  end

  def read
    params[:page_id] = 1 if params[:page_id].nil?
    load_post params[:post_id]
    load_page params[:page_id]
    load_announcement
  end

  def update
    unless params[:id].nil?
      post2update = Post.find_by_id(params[:id])
      if is_owner_of post2update or user_admin?
        post2update.title = params[:title]
        post2update.body = params[:body]
        post2update.rendered = @@markdown.render(params[:body])
        post2update.save
        redirect_to "/pp2015/board/read/#{params[:page_id]}/#{params[:id]}", notice: "글을 수정하였습니다"
      else
        redirect_to "/pp2015/board/read/#{params[:page_id]}/#{params[:id]}", alert: "이 게시물의 작성자가 아닙니다"
      end
    else
      redirect_to "/pp2015/board/read/#{params[:page_id]}/#{params[:id]}", alert: "잘못된 접근입니다"
    end
  end

  def delete
    if params[:id].present?
      post2delete = Post.find_by_id(params[:id])
      if is_owner_of post2delete or user_admin?
        post2delete.destroy
        redirect_to "/pp2015/board", notice: "Successfully deleted"
      elsif post2delete.nil?
        redirect_to "/pp2015/board", alert: "No such post exists"
      else
        redirect_to "/pp2015/board/read/#{params[:page_id]}/#{post2delete.id}", alert: "Not Authorized"
      end
    else
      redirect_to "/pp2015/board", alert: "Failed to delete post : No such ID exists"
    end
  end

  #### Data Loading for Rendering Templates ########################
  def load_post(post_id = nil)
    @post = Post.find_by_id(post_id)
    return !@post.nil?
  end

  def load_page(pagenum = nil, posts_per_page = 10)
    pagenum = 1 if pagenum.nil?
    pagenum = pagenum.to_i
    @page = Post.limit(posts_per_page).offset(posts_per_page*(pagenum-1)).order(created_at: :desc)

    # Calc Pages Number
    total_page = Post.all.count / posts_per_page + 1
    calc_page_num(pagenum, total_page)

    return @page.nil?? [] : @page
  end

  def load_announcement(limit = 3)
    @announcements = Post.where(is_announcement: true).limit(limit).order(created_at: :desc)
    return @announcements.nil?? [] : @announcements
  end

  def is_owner_of(post = nil)
    (!post.nil?) and (!post.user.nil?) and (session[:user_id]==post.user.id)
  end
end
