class Post < ApplicationRecord
    belongs_to :user ,:class_name=>"User", foreign_key: "user_id"
    belongs_to :group

    # has_many :group_relationships


    validates :content , presence: true

    scope :recentt, ->{order("created_at DESC")}
end
