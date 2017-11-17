class Store < ApplicationRecord
	belongs_to :user

	mount_uploader :upload, FileUploader

	validates_presence_of :upload ,:on => :create

	validates_presence_of :folderType, :on => :create

end
