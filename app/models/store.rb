class Store < ApplicationRecord
	belongs_to :user

	mount_uploader :upload, FileUploader

	validates_presence_of :upload

	validates_presence_of :folderType


end
