class Share < ApplicationRecord
	belongs_to :store

	serialize :permission


	before_save :make_array


 def make_array
  self.permission.reject!(&:blank?) if self.permission
  end

end
