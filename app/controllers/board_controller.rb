class BoardController < ApplicationController
  before_filter :signin_required
  before_action -> {
    set_navbar_category "board"
  }
  def index
    params[:post_id] = nil
    params[:page_id]= 0
    page
    render :template => "board/page"
  end
  
  def new
  end
  
  def create
    post2create = Post.new
    post2create.user_id = session[:user_id]
    post2create.title = params[:title]
    post2create.body = params[:body]
    post2create.is_announcement = User.find_by_id(session[:user_id]).is_admin unless User.find_by_id(session[:user_id]).nil?
    post2create.save
    redirect_to "/board/page/0/#{post2create.id}"
  end

  # /board/page/:page_id/:post_id
  def page
    load_post params[:post_id]
    load_page params[:page_id]
    load_announcement
  end

  def edit #has own vie
    @post2edit = Post.find_by_id(params[:id])
    if is_owner_of @post2edit
      params[:user_id] = 0
      params[:user_id] = @post2edit.user.id unless @post2edit.user.nil?
    elsif params[:page_id].nil?
      redirect_to "/board/page"
    elsif params[:id].nil?
      redirect_to "/board/page/#{params[:page_id]}"
    else
      redirect_to "/board/page/#{params[:page_id]}/#{params[:id]}"
    end
  end
  
  def update
    unless params[:id].nil?
      post2update = Post.find_by_id(params[:id])
      if is_owner_of post2update
        post2update.title = params[:title]
        post2update.body = params[:body]
        post2update.save
      end
    end
    redirect_to "/board/page/#{params[:page_id]}/#{params[:id]}"
  end
  
  #### Data Loading for Rendering Templates ########################
  def load_post(post_id = nil)
    @post = Post.find_by_id(post_id)
    return !@post.nil?
  end
  
  def load_page(pagenum = nil, posts_per_page = 10)
    pagenum = 0 if pagenum.nil?
    pagenum = pagenum.to_i
    @page = Post.where(is_announcement: false).limit(posts_per_page).offset(posts_per_page*pagenum).order(created_at: :desc)
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