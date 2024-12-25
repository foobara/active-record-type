module Foobara
  module ActiveRecordType
    module TypeDeclarationHandlers
      class ExtendActiveRecordTypeDeclaration < ExtendDetachedEntityTypeDeclaration
        class PrimaryKeyDesugarizer < ExtendDetachedEntityTypeDeclaration::PrimaryKeyDesugarizer
        end
      end
    end
  end
end
