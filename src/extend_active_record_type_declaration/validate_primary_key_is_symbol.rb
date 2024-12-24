module Foobara
  module TypeDeclarations
    module Handlers
      class ExtendActiveRecordTypeDeclaration < ExtendDetachedEntityTypeDeclaration
        class ValidatePrimaryKeyIsSymbol < ExtendDetachedEntityTypeDeclaration::ValidatePrimaryKeyIsSymbol
        end
      end
    end
  end
end
