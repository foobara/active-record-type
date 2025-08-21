module Foobara
  module ActiveRecordType
    class ExtendActiveRecordTypeDeclaration < TypeDeclarations::Handlers::ExtendDetachedEntityTypeDeclaration
      def applicable?(sugary_type_declaration)
        if sugary_type_declaration.class?
          sugary_type_declaration.declaration_data < ActiveRecord::Base
        end || super
      end

      def expected_type_symbol
        :active_record
      end

      def priority
        super - 1
      end
    end
  end
end
