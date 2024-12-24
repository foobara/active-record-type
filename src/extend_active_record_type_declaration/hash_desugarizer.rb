module Foobara
  module TypeDeclarations
    module Handlers
      class ExtendActiveRecordTypeDeclaration < ExtendDetachedEntityTypeDeclaration
        class HashDesugarizer < ExtendDetachedEntityTypeDeclaration::HashDesugarizer
          def expected_type_symbol
            :active_record
          end
        end
      end
    end
  end
end
