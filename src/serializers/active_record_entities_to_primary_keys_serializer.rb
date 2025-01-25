require "foobara/command_connectors"

module Foobara
  module CommandConnectors
    module Serializers
      class ActiveRecordEntitiesToPrimaryKeysSerializer < EntitiesToPrimaryKeysSerializer
        def serialize(object)
          if object.is_a?(ActiveRecord::Base)
            attribute = object.class.primary_key
            object.send(attribute)
          else
            super
          end
        end
      end
    end
  end
end
