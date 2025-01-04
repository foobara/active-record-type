module Foobara
  module ActiveRecordType
    class ExtendActiveRecordTypeDeclaration < TypeDeclarations::Handlers::ExtendDetachedEntityTypeDeclaration
      class ValidatePrimaryKeyPresent <
        TypeDeclarations::Handlers::ExtendDetachedEntityTypeDeclaration::ValidatePrimaryKeyPresent
      end
    end
  end
end
