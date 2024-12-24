module Foobara
  module TypeDeclarations
    module Handlers
      class ExtendActiveRecordTypeDeclaration < ExtendDetachedEntityTypeDeclaration
        class ValidatePrimaryKeyPresent < ExtendDetachedEntityTypeDeclaration::ValidatePrimaryKeyPresent
        end
      end
    end
  end
end
