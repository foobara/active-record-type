module Foobara
  module ActiveRecordType
    class ExtendActiveRecordTypeDeclaration < TypeDeclarations::Handlers::ExtendDetachedEntityTypeDeclaration
      class HashDesugarizer < TypeDeclarations::Handlers::ExtendDetachedEntityTypeDeclaration::HashDesugarizer
        def expected_type_symbol
          :active_record
        end
      end
    end
  end
end
