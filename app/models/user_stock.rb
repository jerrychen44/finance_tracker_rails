class UserStock < ApplicationRecord
  #[Jerry] this models created by scaffold but need
  #add the association by myself.
  #the rule of belongs_to. The parameter is "modle" name with singular term.(user,stock)
  belongs_to :user
  belongs_to :stock
end
