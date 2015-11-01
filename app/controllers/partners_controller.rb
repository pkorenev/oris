class PartnersController < ApplicationController
  def show
    url = params[:id]
    @partner = Partner.translation_class.where(url_fragment: url).first.try(&:item)
  end
end