class PagesController < ApplicationController
  def stub
    @phones = ["+7 7172 539 277", "+7 7172 539 275", "+7 7273 30 2323", "+7 7272 59 6263"]
    @mail = "info@orislegal.com"
    render layout: false
  end

  def index

  end

  def about

  end
end
