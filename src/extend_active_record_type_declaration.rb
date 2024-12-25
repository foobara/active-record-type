module Foobara
  module ActiveRecordType
    module TypeDeclarationHandlers
      class ExtendActiveRecordTypeDeclaration < ExtendDetachedEntityTypeDeclaration
        def applicable?(*args, **opts, &)
          arg = args.first
          (arg.is_a?(Class) && arg < ActiveRecord::Base) || super
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
end
