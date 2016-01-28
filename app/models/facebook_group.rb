class FacebookGroup < ActiveRecord::Base
  belongs_to :user
  validates_uniqueness_of :group_id, scope: :user_id
end
