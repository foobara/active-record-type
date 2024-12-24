module Foobara
  module TypeDeclarations
    module Handlers
      class ExtendActiveRecordTypeDeclaration < ExtendDetachedEntityTypeDeclaration
        class AttributesHandlerDesugarizer < ExtendDetachedEntityTypeDeclaration::AttributesHandlerDesugarizer
          def expected_type_symbol
            :active_record
          end
        end
      end
    end
  end
end
