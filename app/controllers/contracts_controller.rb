class ContractsController < ApplicationController

	def index
		if logged_in?
			@user = current_user
	
		else
			redirect_to '/'
		end
	end

	def new
	end


	def create
		if logged_in? && User.find_by(username: params["contract"]["borrower"])

			# add error message if and logic if tool not selected (first add blank option to tool select)
			# also need to control for whether tool is already loaned out, but better place for that is the tool select menu logic
	
			@contract = Contract.create
			@contract.loaner = current_user
			@contract.borrower = User.find_by(username: params["contract"]["borrower"])
			@contract.tool = Tool.find_by(name: params["contract"]["tool"])
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
				@contract.active = false
				@contract.save
				# add message "@tool.name returned"
			elsif params[:extend]
				# change due date, which doesn't exist yet
			end
			redirect_to user_contracts_path(current_user)
		end
	end


end
