class Group < ApplicationRecord
    validates :title , presence: true
    validates_uniqueness_of :title 

end
