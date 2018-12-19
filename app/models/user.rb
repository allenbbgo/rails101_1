class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :groups
  has_many :posts

  has_many :group_relationships
  # has_many :groups, :through => :group_relationships
 # has_many :self_groups, ->{where(title: 't1')}, class_name: "Group" , dependent: :destroy

   has_many :zxcer_groups, :through => :group_relationships, :source => :group
  
  def is_member_of?(group)
    #在rails c 裡面呼叫的話要變成     User.first.zxcer_groups.include?(group)

    zxcer_groups.include?(group)
    
  end

  def Join!(group)
    zxcer_groups << group
  end

  def Quit!(group)
    zxcer_groups.delete(group)
  end




end
