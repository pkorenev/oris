class PartnerCompanyFeedback < CompanyFeedback
  belongs_to :partner
  attr_accessible :partner
end