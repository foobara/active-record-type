module Foobara
  module CommandConnectors
    module Serializers
      class ActiveRecordAggregateSerializer < AggregateSerializer
        def serialize(object)
          if object.is_a?(ActiveRecord::Base)
            super(object.attributes)
          else
            super
          end
        end
      end
    end
  end
end
