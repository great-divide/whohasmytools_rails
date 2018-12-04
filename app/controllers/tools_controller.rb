class ToolsController < ApplicationController

	def new
		@tool = Tool.new
	end

	def create
		if logged_in?
			@tool = Tool.new(tool_params)
			@tool.user_id = current_user.id

			if @tool.valid?
				@tool.save
				redirect_to user_path(current_user.id)
			end
		else
			# add error message
			redirect_to user_path(current_user.id)
		end
	end


private
	def tool_params
		params.require(:tool).permit(:name, :description, :user_id)
	end
end
