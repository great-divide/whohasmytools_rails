class ContractsController < ApplicationController
	

	def index
		if logged_in?
			@user = current_user
	
		else
			redirect_to '/'
		end
	end

	def new
		@contract = Contract.new
		@tool = Tool.find(params[:tool_id])
		@user = current_user
	end


	def create
		if logged_in? && User.find_by(username: params["contract"]["borrower"])

			# add error message if and logic if tool not selected (first add blank option to tool select)
	
			@contract = Contract.create
			@contract.loaner = current_user
			@contract.borrower = User.find_by(username: params["contract"]["borrower"])
				if params["contract"]["tool"]
					@contract.tool =Tool.find_by(name: params["contract"]["tool"])
				elsif params["tool_id"]
					@contract.tool = Tool.find_by(id: params[:tool_id])
				end
			@contract.save

			redirect_to user_contracts_path(current_user)
		end
	end

	def show
		if logged_in?
			@user = current_user
		else
			redirect_to '/'
		end
	end

	def update
		if logged_in?
			@contract = Contract.find_by(id: params[:id])
			if params[:return]
				@contract.terminate
				# add message "@tool.name returned"
			elsif params[:extend]
				# change due date, which doesn't exist yet
			end
			redirect_to user_contracts_path(current_user)
		end
	end

private
	def contract_params
		params.require(:contract).permit(:tool_id)
	end

end
