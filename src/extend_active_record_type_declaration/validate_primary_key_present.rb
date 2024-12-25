module Foobara
  module ActiveRecordType
    module TypeDeclarationHandlers
      class ExtendActiveRecordTypeDeclaration < ExtendDetachedEntityTypeDeclaration
        class ValidatePrimaryKeyPresent < ExtendDetachedEntityTypeDeclaration::ValidatePrimaryKeyPresent
        end
      end
    end
  end
end
