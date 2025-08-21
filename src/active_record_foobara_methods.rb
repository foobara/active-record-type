module Foobara
  module ActiveRecordType
    module ActiveRecordFoobaraMethods
      extend ActiveSupport::Concern

      class_methods do
        attr_accessor :foobara_type, :foobara_attributes_type

        # TODO: implement this or figure out how to re-use the methods from Entity/Model
        def foobara_associations
          {}
        end

        def foobara_delegates
          {}
        end

        def foobara_private_attribute_names
          []
        end

        # TODO: implement this or figure out how to re-use the methods from Entity/Model
        def foobara_deep_associations
          # TODO: test this
          # :nocov:
          {}
          # :nocov:
        end

        def foobara_model_name
          foobara_type&.scoped_name || Util.non_full_name(self)
        end

        def foobara_primary_key_attribute
          primary_key&.to_sym
        end

        def foobara_primary_key_type
          return @foobara_primary_key_type if @foobara_primary_key_type

          domain = foobara_type.foobara_domain
          declaration = Foobara::ActiveRecordType.column_name_to_foobara_type_declaration(self, primary_key)
          @foobara_primary_key_type = domain.foobara_type_from_declaration(declaration)
        end

        def foobara_attributes_for_create(...)
          attributes = super

          if attributes.is_a?(Types::Type)
            attributes = attributes.declaration_data
          end

          TypeDeclarations::Attributes.reject(attributes, :created_at, :updated_at)
        end

        def foobara_attributes_for_update(...)
          TypeDeclarations::Attributes.reject(super, :created_at, :updated_at)
        end

        def foobara_attributes_for_aggregate_update(...)
          TypeDeclarations::Attributes.reject(super, :created_at, :updated_at)
        end

        def foobara_attributes_for_atom_update(...)
          TypeDeclarations::Attributes.reject(super, :created_at, :updated_at)
        end

        def foobara_attributes_for_find_by(...)
          TypeDeclarations::Attributes.reject(super, :created_at, :updated_at)
        end
      end
    end
  end
end
