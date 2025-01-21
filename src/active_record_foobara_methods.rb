module ActiveRecordFoobaraMethods
  extend ActiveSupport::Concern

  class_methods do
    attr_accessor :foobara_type, :foobara_attributes_type

    # TODO: implement this or figure out how to re-use the methods from Entity/Model
    def foobara_associations
      {}
    end
  end
end

ActiveRecord::Base.include ActiveRecordFoobaraMethods
