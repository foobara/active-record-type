module Foobara
  module ActiveRecordType
    module Casters
      # TODO: We need a way of disabling/enabling this and it should probably be disabled by default.
      class Hash < BuiltinTypes::DetachedEntity::Casters::Hash
        def build_method(_attributes)
          :new
        end

        def expected_type_symbol
          :active_record
        end
      end
    end
  end
end
