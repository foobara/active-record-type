module Foobara
  module ActiveRecordType
    class ExtendActiveRecordTypeDeclaration < TypeDeclarations::Handlers::ExtendDetachedEntityTypeDeclaration
      module TypeDeclarationExtension
        module RegisteredTypeDeclaration
          module Desugarizers
            class UnregisteredActiveRecordBaseClassDesugarizer < TypeDeclarations::Desugarizer
              def applicable?(sugary_type_declaration)
                if sugary_type_declaration.class?
                  klass = sugary_type_declaration.declaration_data
                  klass < ActiveRecord::Base && !klass.foobara_type
                end
              end

              # We will create the foobara type from the active record class and then the
              # RegisteredActiveRecordBaseClassDesugarizer
              # will handle it properly.
              # This will keep declarations using just the active record class simple in the first place they are used
              # by acting as if it were a registered type at the time even though it wasn't yet.
              def desugarize(sugary_type_declaration)
                klass = sugary_type_declaration.declaration_data

                handler = handler_for_class(Foobara::ActiveRecordType::ExtendActiveRecordTypeDeclaration)
                handler.process_value!(sugary_type_declaration)

                sugary_type_declaration.declaration_data = klass.foobara_type.foobara_manifest_reference.to_sym
                sugary_type_declaration.handle_symbolic_declaration

                sugary_type_declaration
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
