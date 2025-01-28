require "foobara/all"

module Foobara
  # TODO: I think we should have a configuration that indicates if created records can have primary keys past to them
  # or not. That is, do primary keys get issued by the database upon insertion? Or are they generated externally
  # and passed in? Would be nice to have programmatic clarification via explicit configuration.
  module ActiveRecordType
    class << self
      def install!
        TypeDeclarations.register_type_declaration(ExtendActiveRecordTypeDeclaration.new)

        detached_entity = Namespace.global.foobara_lookup_type!(:detached_entity)
        type = BuiltinTypes.build_and_register!(
          :active_record,
          detached_entity,
          nil,
          type_module: Foobara::ActiveRecordType
        )
        type.remove_processor_by_symbol(:attributes_declaration)

        BuiltinTypes.install_type_declaration_extensions_for(ExtendActiveRecordTypeDeclaration)

        ActiveRecord::Base.include ModelAttributeHelpers::Concerns::AttributeHelpers
        ActiveRecord::Base.include ActiveRecordFoobaraMethods

        if defined?(Foobara::CommandConnectors::RailsCommandConnector)
          Foobara::CommandConnectors::RailsCommandConnector.default_serializers = [
            Foobara::CommandConnectors::Serializers::ErrorsSerializer,
            Foobara::CommandConnectors::Serializers::ActiveRecordAtomicSerializer,
            Foobara::CommandConnectors::Serializers::JsonSerializer
          ]
        end
      end

      def reset_all
        Entity::Concerns::Callbacks.reset_all

        install!
      end
    end
  end

  Monorepo.project "active_record_type", project_path: "#{__dir__}/../../"
end
