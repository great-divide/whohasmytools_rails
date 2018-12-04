class ToolsController < ApplicationController

	def index
		if logged_in?
			@user = current_user
		else
			redirect_to '/'
		end
	end

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

	def show
		if logged_in?
			@tool = Tool.find_by(id: params[:id])
		else
			redirect_to '/'
		end
	end

	def edit
		if logged_in?
			@tool = Tool.find_by(id: params[:id])
		else
			redirect_to '/'
		end
	end

	def update
    @tool = Tool.find_by_id(params[:id])
    @tool.update(tool_params)
    if @tool.save
      redirect_to tool_path(@tool)
    else
      render :edit
    end
  end

  def destroy
  	# binding.pry
  	if logged_in?
  		if !@tool.active
		  	@tool = Tool.find_by(id: params[:id])
		  	@tool.destroy
		  	redirect_to user_tools_path(current_user)
		  elsif @tool.active
		  	# error message:  "So and so  is borrowing that tool right now!"
		  	redirect_to user_tools(current_user)
		  end
	  else
	  	redirect_to '/'
	  end
  end


private
	def tool_params
		params.require(:tool).permit(:name, :description, :user_id)
	end
end
