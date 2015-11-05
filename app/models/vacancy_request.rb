class VacancyRequest < ActiveRecord::Base
  attr_accessible *attribute_names

  belongs_to :vacancy
  attr_accessible :vacancy

  validates :vacancy, :phone, :email, :cv, presence: true

  has_attached_image :cv


end
