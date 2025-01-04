module Foobara
  module ActiveRecordType
    class ExtendActiveRecordTypeDeclaration < TypeDeclarations::Handlers::ExtendDetachedEntityTypeDeclaration
      class ValidatePrimaryKeyIsSymbol <
        TypeDeclarations::Handlers::ExtendDetachedEntityTypeDeclaration::ValidatePrimaryKeyIsSymbol
      end
    end
  end
end
