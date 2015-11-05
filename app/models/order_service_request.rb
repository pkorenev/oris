class OrderServiceRequest < ActiveRecord::Base
  attr_accessible *attribute_names
  validates   :company_name, :activity_scope, :contact_person, :phone, :email, :description, presence: true


end
