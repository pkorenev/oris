module ApplicationHelper
  # ============================================
  # --------------------------------------------
  # image helpers
  # --------------------------------------------
  # ============================================


  # http://placehold.it/300x200&text=some_text
  def stub_image_link(width = 420, height = 350, text = 'item 1')
    image_url = "http://placehold.it/#{width}x#{height}&text=#{text}"
    image_url
  end

  def stub_image(width = 420, height = 350, text = 'item 1', options = {})
    image_url = stub_image_link
    options[:src] = image_url
    output = "<img "
    options.each_pair do |key, value|
      output += "#{key}='#{value}' "
    end
    output += "/>"
    output.html_safe
  end

  def self.self_js_embedded_svg filename, options={}
    file = File.read(Rails.root.join('app', 'assets', 'images', filename))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    if options[:class].present?
      svg['class'] = options[:class]
    end
    source = svg.to_html
    minimized_source = source
    minimized_source = minimized_source.remove("\r")
    minimized_source = minimized_source.remove("\t")
    minimized_source = minimized_source.remove("\n")
    minimized_source
  end

  def js_embedded_svg filename, options={}
    self.self_js_embedded_svg(filename, options)
  end

  def self.self_embedded_svg_from_assets filename, options = {}
    self.self_embedded_svg("/app/assets/images/#{filename}", options)
  end

  def embedded_svg_from_assets filename, options = {}
    ApplicationHelper.self_embedded_svg_from_assets(filename, options)
  end

  def embedded_svg_from_public filename, options = {}
    self.self_embedded_svg("#{filename}", options)
  end

  def self.self_embedded_svg_from_public filename, options = {}
    embedded_svg("/public/#{filename}", options)
  end

  def self.self_embedded_svg filename, options={}
    self.self_embedded_svg_from_absolute_path(Rails.root.to_s + filename.to_s, options)
  end

  def embedded_svg filename, options={}
    self.class.self_embedded_svg(filename, options)
  end

  def self.self_embedded_svg_from_absolute_path(filename, options = {})
    filename = "#{filename}.svg" if filename.scan(/\.svg\Z/).empty?
    file = File.read(filename.to_s)
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    if options[:class].present?
      svg['class'] = options[:class]
    end
    doc.to_html.html_safe
  end

  def embedded_svg_from_absolute_path(filename, options = {})
    self.class.self_embedded_svg_from_absolute_path(filename, options)
  end

  def image_or_stub_url(paperclip_instance, style = :original, width=250, height=250, text='image')
    ( (paperclip_instance && paperclip_instance.respond_to?(:exists?) && paperclip_instance.exists?(style) && paperclip_instance.respond_to?(:url) )? paperclip_instance.url(style) : stub_image_link(width, height, text) )
  end

  def images_root
    "/assets/application"
  end
end
