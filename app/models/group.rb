class Group < ApplicationRecord
    belongs_to :user

    validates :title , presence: true
    validates_uniqueness_of :title 



end
