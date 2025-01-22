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

        def foobara_primary_key_attribute
          primary_key
        end

        def foobara_primary_key_type
          return @foobara_primary_key_type if @foobara_primary_key_type

          domain = foobara_type.foobara_domain
          declaration = Foobara::ActiveRecordType.column_name_to_foobara_type_declaration(self, primary_key)
          @foobara_primary_key_type = domain.foobara_type_from_declaration(declaration)
        end

        def foobara_attributes_for_create(...)
          TypeDeclarations::Attributes.reject(super, :created_at, :updated_at)
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
