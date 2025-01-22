module Foobara
  module ActiveRecordType
    class << self
      def column_name_to_foobara_type_declaration(active_record_class, name)
        column = column_from_name(active_record_class, name)
        column_to_foobara_type_declaration(column)
      end

      def column_to_foobara_type_declaration(column)
        column_type = column.sql_type_metadata.type

        type_declaration = case column_type
                           when :integer, :string, :datetime
                             column_type
                           else
                             # :nocov:
                             raise ArgumentError, "Not sure how to convert #{column_type} to a foobara type symbol"
                             # :nocov:
                           end

        # defaults and required will be handled further up
        if column.null
          { type: type_declaration, allow_nil: true }
        else
          type_declaration
        end
      end

      def column_from_name(active_record_class, name)
        active_record_class.columns.find do |column|
          column.name == name
        end
      end
    end
  end
end
