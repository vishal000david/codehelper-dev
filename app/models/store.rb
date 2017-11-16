class Store < ApplicationRecord
	belongs_to :user

	mount_uploader :upload, FileUploader

end
