class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   has_many :stores
   has_one  :membership
   has_many :folders

   after_create :create_member

   def create_member 
    @member_params = {memberType: "Normal" ,totalQuota: 10000}
    @membership = self.build_membership(@member_params)
    @membership.save
    end

end
