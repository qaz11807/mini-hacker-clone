class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  PER_PAGE = 10
end
