module ActiveScaffold::DataStructures
  class ListFilters < Set

    def initialize
      @set = []
			@columns = {}
    end

    # adds an ListFilter, creating one from the arguments if need be
    def add(filter_type, filter_name, columns, options = {}, defaults = {})
			filter_class = ("ListFilters::#{filter_type.to_s.camelize}Filter").constantize
			filter = filter_class.new(filter_name, columns, options, defaults)
			@set << filter # unless @set.any? {|f| f.filter == filter.filter}
		end
    alias_method :<<, :add

    # finds an ListFilter by matching the filtername
		# doesn't make sense.. can have more then one filter of each type
    def [](val)
      @set.find {|item| item.filter == val}
    end

    def delete(val)
      index_to_delete = nil
      @set.each_with_index {|item, index| index_to_delete = index; break if item.filter == val}
      @set.delete_at(index_to_delete) unless index_to_delete.nil?
    end

    # iterates over the filters, possibly by type
    def each(type = nil)
      type = type.to_sym if type
      @set.each {|item|
        next if type and item.type != type
        yield item
      }
    end

    def empty?
      @set.size == 0
    end

    protected

    # called during clone or dup. makes the clone/dup deeper.
    def initialize_copy(from)
      @set = []
      from.instance_variable_get('@set').each { |filter| @set << filter.clone }
    end

  end
end