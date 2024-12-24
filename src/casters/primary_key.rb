module Foobara
  module BuiltinTypes
    module ActiveRecord
      module Casters
        class PrimaryKey < Value::Caster
          class << self
            def requires_declaration_data?
              true
            end

            def requires_type?
              true
            end
          end

          def type
            declaration_data
          end

          def active_record_class
            type.target_class
          end

          def primary_key_type
            primary_key_attribute_name = type.declaration_data[:primary_key]
            type.element_types[primary_key_attribute_name]
          end

          def applicable?(value)
            primary_key_type.applicable?(value)
          end

          def cast(primary_key)
            ActiveRecordThunk.new(active_record_class, primary_key)
          end

          def applies_message
            primary_key_type.value_caster.applies_message
          end
        end
      end
    end
  end
end
