module Foobara
  module ActiveRecordType
    class ExtendActiveRecordTypeDeclaration < TypeDeclarations::Handlers::ExtendDetachedEntityTypeDeclaration
      module TypeDeclarationExtension
        module RegisteredTypeDeclaration
          module Desugarizers
            class RegisteredActiveRecordBaseClassDesugarizer < TypeDeclarations::Desugarizer
              def applicable?(sugary_type_declaration)
                sugary_type_declaration.is_a?(Class) && sugary_type_declaration < ActiveRecord::Base &&
                  sugary_type_declaration.foobara_type
              end

              def desugarize(active_record_class)
                {
                  type: active_record_class.foobara_type.foobara_manifest_reference.to_sym
                }
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
