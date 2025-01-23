module Foobara
  # NOTE: it can help when debugging to comment out the inheritance from BasicObject
  class ActiveRecordThunk < BasicObject
    def initialize(active_record_class, primary_key)
      super()

      @foobara_active_record_class = active_record_class
      @foobara_primary_key_attribute = active_record_class.foobara_type.declaration_data[:primary_key]
      @foobara_primary_key = primary_key
    end

    # BasicObject doesn't have .respond_to? nor .respond_to_missing? so disable this cop
    # rubocop:disable Style/MissingRespondToMissing
    def method_missing(method_name, ...)
      if method_name == @foobara_primary_key_attribute
        return @foobara_primary_key
      end

      foobara_load_if_needed(method_name)

      @foobara_active_record.send(method_name, ...)
    end
    # rubocop:enable Style/MissingRespondToMissing

    def respond_to?(method_name, include_private = false)
      method_name = method_name.to_sym

      case method_name
      when :foobara_load_if_needed
        include_private
      when :foobara_active_record_class, :foobara_primary_key_attribute, :foobara_primary_key
        true
      else
        @foobara_active_record.respond_to?(method_name, include_private) ||
          foobara_active_record_class.instance_methods.include?(method_name)
      end
    end

    # BasicObject doesn't have .attr_reader
    # rubocop:disable Style/TrivialAccessors
    def foobara_active_record_class
      @foobara_active_record_class
    end

    def foobara_primary_key_attribute
      @foobara_primary_key_attribute
    end

    def foobara_primary_key
      @foobara_primary_key
    end
    # rubocop:enable Style/TrivialAccessors

    def ==(other)
      return false unless @foobara_primary_key

      other.instance_of?(@foobara_active_record_class) && @foobara_primary_key == other.id
    end

    private

    # TODO: there are probably several other methods that don't require loading
    def foobara_load_if_needed(method_name)
      return if defined?(@foobara_active_record)
      return if method_name == @foobara_primary_key_attribute

      @foobara_active_record = @foobara_active_record_class.find(@foobara_primary_key)
    end
  end
end
