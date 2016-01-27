class User < ActiveRecord::Base
  include Clearance::User

  has_many :facebook_groups, dependent: :destroy
  has_many :facebook_pages, dependent: :destroy
end
