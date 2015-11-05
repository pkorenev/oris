module HasTags
  module ActiveRecordExtensions
    module ClassMethods
      # def has_tags1
      #   has_many :taggings, as: :taggable
      #   has_many :tags, through: :taggings
      #
      #   has_one name, -> { where(assetable_field_name: name) }, class_name: "Asset", as: :assetable, dependent: :destroy, autosave: true
      # end

      def has_tags(name = :tags, options = {})
        name = name.to_sym
        if self._reflections.keys.map(&:to_s).include?(name.to_s)
          return false
        end

        taggings_association_name = "#{name}_taggings".to_sym

        has_many taggings_association_name, -> { where(taggable_field_name: name) }, class_name: "HasTags::Tagging", as: :taggable, dependent: :destroy, autosave: true
        has_many name, through: taggings_association_name, class_name: "HasTags::Tag"

        attr_accessible taggings_association_name, "#{taggings_association_name.to_s.singularize}_ids"
        attr_accessible name, "#{name.to_s.singularize}_ids"

        # define_method "#{name}_tag_options".to_sym do
        #   options
        # end

        # define_method "#{name}=".to_sym do |val|
        #   if val.is_a?(File)
        #     asset = send(name)
        #     asset = self.association(name).build() if asset.nil?
        #     asset.assign_attributes(data: val)
        #   end
        # end

        # define_method "delete_#{name}" do
        #   self.send(name).delete
        # end

        attr_accessible name
      end
    end
  end
end


ActiveRecord::Base.send(:extend, HasTags::ActiveRecordExtensions::ClassMethods)