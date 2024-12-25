module Foobara
  module ActiveRecordType
    module TypeDeclarationHandlers
      class ExtendActiveRecordTypeDeclaration < ExtendDetachedEntityTypeDeclaration
        class ValidatePrimaryKeyIsSymbol < ExtendDetachedEntityTypeDeclaration::ValidatePrimaryKeyIsSymbol
        end
      end
    end
  end
end
