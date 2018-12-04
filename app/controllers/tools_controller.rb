class ToolsController < ApplicationController

	def new
		@tool = Tool.new
	end

	def create
		@tool = Tool.new(tool_params)

		if @tool.valid?
			@tool.save

			redirect_to tool_path(@tool)
		else
			redirect_to user_path(current_user.id)
		end
	end


private
	def tool_params
		params.require(:tool).permit(:name, :description)
	end
end
