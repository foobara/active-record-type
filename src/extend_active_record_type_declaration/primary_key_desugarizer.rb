module Foobara
  module ActiveRecordType
    class ExtendActiveRecordTypeDeclaration < TypeDeclarations::Handlers::ExtendDetachedEntityTypeDeclaration
      class PrimaryKeyDesugarizer <
        TypeDeclarations::Handlers::ExtendDetachedEntityTypeDeclaration::PrimaryKeyDesugarizer
      end
    end
  end
end
