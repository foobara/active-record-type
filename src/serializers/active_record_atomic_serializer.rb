module Foobara
  module CommandConnectors
    module Serializers
      class ActiveRecordAtomicSerializer < AtomicSerializer
        def serialize(object)
          if object.is_a?(ActiveRecord::Base)
            super(
              entities_to_primary_keys_serializer.serialize(object.attributes)
            )
          else
            super
          end
        end

        def entities_to_primary_keys_serializer
          @entities_to_primary_keys_serializer ||= ActiveRecordEntitiesToPrimaryKeysSerializer.new(declaration_data)
        end
      end
    end
  end
end
