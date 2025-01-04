module Foobara
  module ActiveRecordType
    class ExtendActiveRecordTypeDeclaration < TypeDeclarations::Handlers::ExtendDetachedEntityTypeDeclaration
      class ModelClassDesugarizer <
        TypeDeclarations::Handlers::ExtendDetachedEntityTypeDeclaration::ModelClassDesugarizer
        def expected_type_symbol
          :active_record
        end
      end
    end
  end
end
