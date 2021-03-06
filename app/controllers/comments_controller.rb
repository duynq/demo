class CommentsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy

	def create
		@comment = current_user.comments.build(comment_params)
		if @comment.save
			flash[:success] = "Comment posted!"
			redirect_to @comment.blog
		else
			redirect_to @comment.blog
		end
	end

	def destroy
		@comment.destroy
		flash[:success] = "Comment deleted!"
		redirect_to @comment.blog
	end

	private 
		def comment_params
			params.require(:comment).permit(:content, :blog_id)
		end

		def correct_user
			@comment = current_user.comments.find_by(id: params[:id])
			redirect_to root_url if @comment.nil?
		end

end
