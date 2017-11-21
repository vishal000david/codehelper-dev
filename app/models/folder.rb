class Folder < ApplicationRecord
	belongs_to :user
	validates_uniqueness_of :folderName
	validates_presence_of :folderName
	has_many :stores, dependent: :destroy
end
