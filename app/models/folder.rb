class Folder < ApplicationRecord
	belongs_to :user
	validates_uniqueness_of :folderName
end
