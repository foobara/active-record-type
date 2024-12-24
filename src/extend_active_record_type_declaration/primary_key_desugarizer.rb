module Foobara
  module TypeDeclarations
    module Handlers
      class ExtendActiveRecordTypeDeclaration < ExtendDetachedEntityTypeDeclaration
        class PrimaryKeyDesugarizer < ExtendDetachedEntityTypeDeclaration::PrimaryKeyDesugarizer
        end
      end
    end
  end
end
