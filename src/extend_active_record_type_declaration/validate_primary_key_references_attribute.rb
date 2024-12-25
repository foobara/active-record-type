module Foobara
  module ActiveRecordType
    module TypeDeclarationHandlers
      class ExtendActiveRecordTypeDeclaration < ExtendDetachedEntityTypeDeclaration
        class ValidatePrimaryKeyReferencesAttribute <
          ExtendDetachedEntityTypeDeclaration::ValidatePrimaryKeyReferencesAttribute
        end
      end
    end
  end
end
