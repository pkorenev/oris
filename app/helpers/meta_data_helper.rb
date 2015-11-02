module MetaDataHelper
  def head_title
    title = @head_title

    title = @page_metadata.try do |m|
      if m.is_a?(Hash)
        break m[:head_title]
      else
        break m.head_title
      end
    end if title.blank?


    title = (@page || @resource).try{|p| p.seo_tags.try(&:title) if p.respond_to?(:seo_tags) } if title.blank?
    title = (@resource).try{|m| m.title if m.respond_to?(:title); m.meta_title if m.respond_to?(:meta_title) } if title.blank?
    title = @resource.try{|r|  } if title.blank?
    title = I18n.t("head_title_untitled") if title.blank?
    #raw I18n.t("head_title", title: title)

    title
  end

  def meta_keywords
    keywords = @meta_keywords
    keywords = (@page || @resource).try{|p| p.seo_tags.try(&:keywords) if p.respond_to?(:seo_tags) } if keywords.blank?
    keywords = (@page_metadata || @resource).try{|m| next m.keywords if m.respond_to?(:keywords); next m.meta_keywords if m.respond_to?(:meta_keywords) } if keywords.blank?
    keywords = "" if keywords.blank?
    keywords
  end

  def meta_description
    description = @meta_description
    description = (@page || @resource).try{|p| p.seo_tags.try(&:description) if p.respond_to?(:seo_tags) } if description.blank?
    description = @page_metadata.try{|m| m.description if m.respond_to?(:description) } if description.blank?
    description = @resource.try{|m| next m.meta_description if m.respond_to?(:description); next m.meta_description if m.respond_to?(:meta_description) } if description.blank?
    description = '' if description.blank?
    description
  end

  def seo_tags
    result = ""
    if (title = head_title).present?
      result += content_tag(:title, title)
    end

    if (description = meta_description).present?
      result += content_tag(:meta, nil, content: description, name: "description")
    end

    if (keywords = meta_keywords).present?
      result += content_tag(:meta, nil, name: "keywords", content: keywords)
    end

    result.html_safe
  end
end