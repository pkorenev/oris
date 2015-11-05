class Book < ActiveRecord::Base
  attr_accessor :color, :age
  after_initialize do
    opts = self.options.try{|options| JSON.parse(options) }
    if opts.present?
      self.color = opts['color']
      self.age = opts['age']
    end
  end

  before_save do
    opts ||= {}
    opts[:color] = self.color
    opts[:age] = self.age

    self.options = opts.to_json
  end

  validates :color, presence: true
end
