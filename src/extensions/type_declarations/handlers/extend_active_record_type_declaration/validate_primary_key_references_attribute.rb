module Foobara
  module TypeDeclarations
    module Handlers
      class ExtendActiveRecordTypeDeclaration < ExtendDetachedEntityTypeDeclaration
        class ValidatePrimaryKeyReferencesAttribute <
          ExtendDetachedEntityTypeDeclaration::ValidatePrimaryKeyReferencesAttribute
        end
      end
    end
  end
end
