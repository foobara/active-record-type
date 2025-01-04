module Foobara
  module ActiveRecordType
    class ExtendActiveRecordTypeDeclaration < TypeDeclarations::Handlers::ExtendDetachedEntityTypeDeclaration
      class AttributesHandlerDesugarizer <
        TypeDeclarations::Handlers::ExtendDetachedEntityTypeDeclaration::AttributesHandlerDesugarizer
        def expected_type_symbol
          :active_record
        end
      end
    end
  end
end
