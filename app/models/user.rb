class User < ApplicationRecord
	has_secure_password
	has_many :tools
	accepts_nested_attributes_for :tools
	
	# "loaner_contract == in the role of loaner
	has_many :loaner_contracts, foreign_key: :loaner_id, class_name: "Contract"
	has_many :borrowers, through: :loaner_contracts, source: :borrower 

	# "borrower_contract" ==  in the role of borrower
	has_many :borrower_contracts, foreign_key: :borrower_id, class_name: "Contract"
	has_many :loaners, through: :borrower_contracts, source: :loaner
end
