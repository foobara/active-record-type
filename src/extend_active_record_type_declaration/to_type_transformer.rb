module Foobara
  module TypeDeclarations
    module Handlers
      class ExtendActiveRecordTypeDeclaration < ExtendDetachedEntityTypeDeclaration
        class ToTypeTransformer < ExtendRegisteredTypeDeclaration::ToTypeTransformer
          def process_value(strict_declaration_type)
            super.tap do |outcome|
              if outcome.success?
                type = outcome.result

                active_record_class = type.target_class
                active_record_class.foobara_type = type

                handler = handler_for_class(ExtendAttributesTypeDeclaration)
                attributes_type_declaration = type.declaration_data[:attributes_declaration]

                type.element_types = handler.process_value!(attributes_type_declaration).element_types
                type_name = type.declaration_data[:name]

                # We don't want to check that the active record is valid as if it were a model
                type.validators.delete_if do |validator|
                  validator.symbol == :attributes_declaration
                end

                domain = Domain.domain_through_modules(active_record_class)
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
        end
      end
    end
  end
end
