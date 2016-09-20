class Friendship < ApplicationRecord
  #[Jerry] add for friend system
  belongs_to :user
  #we don't have friend class, the friend in fact it comes from User
  belongs_to :friend,:class_name => 'User'
end
