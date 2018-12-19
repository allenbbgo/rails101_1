class GroupRelationship < ApplicationRecord

    belongs_to :group
    belongs_to :user
  
    # belongs_to :post
end
