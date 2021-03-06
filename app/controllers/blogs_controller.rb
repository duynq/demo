class BlogsController < ApplicationController

	before_action :set_blog, only: [:show, :update, :destroy]
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user,   only: :destroy

	def index
	    @blog = Blog.all.paginate(page: params[:page], per_page: 10)
	end

	def create
		@blog = current_user.blogs.build(blog_params)
	    if @blog.save
	      flash[:success] = "Blog created!"
	      redirect_to root_url
	    else
	    	@feed_items = []
	      	render 'home_pages/home'
	    end
	end
	def show
	    @comment = current_user.comments.build if logged_in?
	    @comments = @blog.comments.paginate(page: params[:page], per_page: 10)
	end

	def destroy
		@blog.destroy
	    flash[:success] = "Blog deleted"
	    redirect_to request.referrer || root_url
	end

	private

		def set_blog
	      @blog = Blog.find(params[:id])
	    end

	    def blog_params
	      params.require(:blog).permit(:title, :content, :picture)
	    end
	    def correct_user
	      @blog = current_user.blogs.find_by(id: params[:id])
	      redirect_to root_url if @blog.nil?
	    end

end
