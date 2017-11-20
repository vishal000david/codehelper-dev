class Store < ApplicationRecord
	belongs_to :user

	mount_uploader :upload, FileUploader

	validates_presence_of :upload ,:on => :create

	validates_presence_of :folderType, :on => :create

	has_many :shares

	after_create :create_share_record

	def create_share_record
		per = ["R","W","X"]
		@share_params = {:reciever_id => self.user_id,:user_id => self.user_id,:permission => per}
		share_rec =  self.shares.build(@share_params)
		share_rec.save
	end

end
