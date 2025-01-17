module Foobara
  module ActiveRecordType
    class ExtendActiveRecordTypeDeclaration < TypeDeclarations::Handlers::ExtendDetachedEntityTypeDeclaration
      module TypeDeclarationExtension
        module RegisteredTypeDeclaration
          module Desugarizers
            class UnregisteredActiveRecordBaseClassDesugarizer < TypeDeclarations::Desugarizer
              def applicable?(sugary_type_declaration)
                sugary_type_declaration.is_a?(Class) && sugary_type_declaration < ActiveRecord::Base &&
                  !sugary_type_declaration.foobara_type
              end

              # We will create the foobara type from the active record class and then the
              # RegisteredActiveRecordBaseClassDesugarizer
              # will handle it properly.
              # This will keep declarations using just the active record class simple in the first place they are used
              # by acting as if it were a registered type at the time even though it wasn't yet.
              def desugarize(active_record_class)
                handler = handler_for_class(Foobara::ActiveRecordType::ExtendActiveRecordTypeDeclaration)
                handler.process_value!(active_record_class)

                {
                  type: active_record_class.foobara_type.foobara_manifest_reference.to_sym
                }
              end

              def priority
                Priority::FIRST - 3
              end
            end
          end
        end
      end
    end
  end
end
