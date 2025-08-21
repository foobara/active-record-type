module Foobara
  module ActiveRecordType
    class ExtendActiveRecordTypeDeclaration < TypeDeclarations::Handlers::ExtendDetachedEntityTypeDeclaration
      class ActiveRecordBaseClassDesugarizer < TypeDeclarations::Desugarizer
        def applicable?(sugary_type_declaration)
          if sugary_type_declaration.class?
            sugary_type_declaration.declaration_data < ActiveRecord::Base
          end
        end

        def desugarize(sugary_type_declaration)
          klass = sugary_type_declaration.declaration_data
          active_record_superclass = klass.superclass

          if active_record_superclass != ActiveRecord::Base
            if active_record_superclass.attribute_names.include?(klass.primary_key)
              # this will register a foobara type for the base class
              type_for_declaration(klass.superclass)
            end
          end

          domain = Foobara::Domain.domain_through_modules(klass)

          name = klass.name.gsub(/^#{domain.scoped_full_name}::/, "")

          sugary_type_declaration.declaration_data = {
            type: :active_record,
            model_class: klass.name,
            name:,
            model_base_class: active_record_superclass.name,
            model_module: Util.module_for(klass)&.name,
            primary_key: klass.primary_key,
            attributes_declaration: active_record_class_to_attributes_declaration(klass)
          }

          sugary_type_declaration.is_duped = true
          sugary_type_declaration.is_deep_duped = true

          sugary_type_declaration
        end

        def column_to_foobara_type_declaration(column)
          ActiveRecordType.column_to_foobara_type_declaration(column)
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
          ActiveRecordType.column_from_name(active_record_class, name)
        end

        def priority
          Priority::FIRST - 1
        end
      end
    end
  end
end
