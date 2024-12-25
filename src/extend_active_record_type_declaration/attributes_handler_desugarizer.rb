module Foobara
  module ActiveRecordType
    module TypeDeclarationHandlers
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
