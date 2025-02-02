module Foobara
  module ActiveRecordType
    class ExtendActiveRecordTypeDeclaration < TypeDeclarations::Handlers::ExtendDetachedEntityTypeDeclaration
      class ToTypeTransformer < TypeDeclarations::Handlers::ExtendRegisteredTypeDeclaration::ToTypeTransformer
        def process_value(strict_declaration_type)
          super.tap do |outcome|
            if outcome.success?
              type = outcome.result

              active_record_class = type.target_class
              active_record_class.foobara_type = type

              handler = handler_for_class(TypeDeclarations::Handlers::ExtendAttributesTypeDeclaration)
              attributes_type_declaration = type.declaration_data[:attributes_declaration]

              active_record_class.foobara_attributes_type = handler.process_value!(attributes_type_declaration)

              type.element_types = active_record_class.foobara_attributes_type.element_types
              type_name = type.declaration_data[:name]

              domain = Domain.domain_through_modules(active_record_class)

              type_name = type_name.gsub(/^#{domain.scoped_full_name}::/, "")

              domain.foobara_register_type(type_name, type)
            end
          end
        end

        def target_classes(strict_type_declaration)
          Object.const_get(strict_type_declaration[:model_class])
        end

        def non_processor_keys
          [
            :primary_key,
            :name,
            :model_class,
            :model_base_class,
            :model_module,
            :attributes_declaration,
            *super
          ]
        end

        def type_class
          Foobara::DetachedEntityType
        end

        def type_name(strict_type_declaration)
          strict_type_declaration[:name]
        end
      end
    end
  end
end
