class Contract < ApplicationRecord
	belongs_to :tool
	belongs_to :loaner, foreign_key: "loaner_id", class_name: "User"
	belongs_to :borrower, foreign_key: "borrower_id", class_name: "User"

	def terminate
		self.update(active: false)
	end
end
