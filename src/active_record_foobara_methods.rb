module ActiveRecordFoobaraMethods
  extend ActiveSupport::Concern

  class_methods do
    attr_accessor :foobara_type, :foobara_attributes_type
  end
end

ActiveRecord::Base.include ActiveRecordFoobaraMethods
