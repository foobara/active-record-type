module Foobara
  module ActiveRecordType
    class ExtendActiveRecordTypeDeclaration < TypeDeclarations::Handlers::ExtendDetachedEntityTypeDeclaration
      module TypeDeclarationExtension
        module RegisteredTypeDeclaration
          module Desugarizers
            class RegisteredActiveRecordBaseClassDesugarizer < TypeDeclarations::Desugarizer
              def applicable?(sugary_type_declaration)
                if sugary_type_declaration.class?
                  klass = sugary_type_declaration.declaration_data

                  if klass < ActiveRecord::Base
                    klass.foobara_type
                  end
                end
              end

              def desugarize(sugary_declaration)
                klass = sugary_declaration.declaration_data
                type = klass.foobara_type

                sugary_declaration.type = type
                sugary_declaration.declaration_data = type.foobara_manifest_reference.to_sym
                sugary_declaration.is_strict = true

                sugary_declaration
              end

              def priority
                Priority::FIRST - 2
              end
            end
          end
        end
      end
    end
  end
end
