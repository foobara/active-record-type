module Foobara
  module ActiveRecordType
    module TypeDeclarationHandlers
      class RegisteredTypeDeclaration < TypeDeclarationHandler
        class RegisteredActiveRecordBaseClassDesugarizer < TypeDeclarations::Desugarizer
          def applicable?(klass)
            klass.is_a?(Class) && klass < ActiveRecord::Base && type_registered?(klass.name)
          end

          def desugarize(active_record_class)
            {
              type: active_record_class.name
            }
          end

          def priority
            Priority::FIRST - 2
          end
        end
      end
    end
  end
end
