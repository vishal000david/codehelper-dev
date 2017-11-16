class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   has_many :stores
   has_one  :membership

   after_create :create_member

   def create_member 
    @member_params = {memberType: "Prime" ,totalQuota: 200000000}
    @membership = self.build_membership(@member_params)
    @membership.save
   end

end
