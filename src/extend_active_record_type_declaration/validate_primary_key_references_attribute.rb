module Foobara
  module ActiveRecordType
    class ExtendActiveRecordTypeDeclaration < TypeDeclarations::Handlers::ExtendDetachedEntityTypeDeclaration
      class ValidatePrimaryKeyReferencesAttribute <
        TypeDeclarations::Handlers::ExtendDetachedEntityTypeDeclaration::ValidatePrimaryKeyReferencesAttribute
      end
    end
  end
end
