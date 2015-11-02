module Images
  module ActiveRecordExtensions
    module ClassMethods
      def has_attached_image(name = :avatar, options = {})

        has_attached_file name, options


        attr_accessible name

        do_not_validate_attachment_file_type name

        attr_accessor :"delete_#{name}"
        attr_accessible :"delete_#{name}"
        before_validation { self.send(name).clear if self.send("delete_#{name}") == '1'}


      end
    end
  end
end

ActiveRecord::Base.send(:extend, Images::ActiveRecordExtensions::ClassMethods)