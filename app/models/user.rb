class User < ApplicationRecord
	has_secure_password
	has_many :tools
	
	# "loaner_contract == in the role of loaner
	has_many :loaner_contracts, foreign_key: :loaner_id, class_name: "Contract"
	has_many :borrowers, through: :loaner_contracts, source: :borrower 

	# "borrower_contract" ==  in the role of borrower
	has_many :borrower_contracts, foreign_key: :borrower_id, class_name: "Contract"
	has_many :loaners, through: :borrower_contracts, source: :loaner

	def active
		array = []
		self.loaner_contracts.each do |c|
			if c.active == true
				array << c
			end
		end
		
		self.borrower_contracts.each do |c|
			if c.active == true
				array << c
			end
		end
		array	
	end

	def active_loans
		array = []
		self.loaner_contracts.each do |c|
			if c.active == true
				array << c
			end
		end
		array	
	end

	def active_borrows
		array = []
		self.borrower_contracts.each do |c|
			if c.active == true
				array << c
			end
		end
		array
	end

	def loan_history
		array = []
		self.loaner_contracts.each do |c|
			if c.active == false
				array << c
			end
		end
		array
	end

	def borrow_history
		array = []
		self.borrower_contracts.each do |c|
			if c.active == false
				array << c
			end
		end
		array
	end
end
