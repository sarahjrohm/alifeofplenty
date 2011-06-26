class PostsController < ApplicationController
  def index
    @tag = params[:tag]
    @posts = Post.paginate :page => params[:page], :order => 'published_at DESC', :per_page=>5 

    respond_to do |format|
      format.html
      format.atom { render :layout => false }
    end
  end

  def show
    @post = Post.find_by_permalink(*([:year, :month, :day, :slug].collect {|x| params[x] } << {:include => [:approved_comments, :tags]}))
    @comment = Comment.new
  end
end
