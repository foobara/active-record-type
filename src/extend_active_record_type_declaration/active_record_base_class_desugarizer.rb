module Foobara
  module ActiveRecordType
    class ExtendActiveRecordTypeDeclaration <  TypeDeclarations::Handlers::ExtendDetachedEntityTypeDeclaration
      class ActiveRecordBaseClassDesugarizer < TypeDeclarations::Desugarizer
        def applicable?(klass)
          klass.is_a?(Class) && klass < ActiveRecord::Base
        end

        def desugarize(active_record_class)
          if active_record_class.superclass != ActiveRecord::Base
            # this will register a foobara type for the base class
            type_for_declaration(active_record_class.superclass)
          end

          {
            type: :active_record,
            model_class: active_record_class.name,
            name: active_record_class.name,
            model_base_class: active_record_class.superclass.name,
            model_module: Util.module_for(active_record_class)&.name,
            primary_key: active_record_class.primary_key,
            attributes_declaration: active_record_class_to_attributes_declaration(active_record_class)
          }
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

        def active_record_class_to_attributes_declaration(active_record_class)
          element_type_declarations = {}
          defaults = {}
          required = []

          active_record_class.attribute_names.each do |attribute_name|
            column = column_from_name(active_record_class, attribute_name)
            element_type_declarations[attribute_name] = column_to_foobara_type_declaration(column)

            if column.has_default?
              defaults[attribute_name] = column.default
            end

            unless column.null
              required << attribute_name
            end
          end

          {
            type: :attributes,
            element_type_declarations:,
            defaults:,
            required:
          }
        end

        def column_from_name(active_record_class, name)
          active_record_class.columns.find do |column|
            column.name == name
          end
        end

        def priority
          Priority::FIRST - 1
        end
      end
    end
  end
end
