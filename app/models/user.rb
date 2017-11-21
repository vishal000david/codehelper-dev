class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   has_many :stores, dependent: :destroy
   has_one  :membership, dependent: :destroy
   has_many :folders, dependent: :destroy

   after_create :create_member

   def create_member 
    @member_params = {memberType: "Normal" ,totalQuota: 10000}
    @membership = self.build_membership(@member_params)
    @membership.save
    end

end
