module Foobara
  module TypeDeclarations
    module Handlers
      class ExtendActiveRecordTypeDeclaration < ExtendDetachedEntityTypeDeclaration
        class ModelClassDesugarizer < ExtendDetachedEntityTypeDeclaration::ModelClassDesugarizer
          def expected_type_symbol
            :active_record
          end
        end
      end
    end
  end
end
