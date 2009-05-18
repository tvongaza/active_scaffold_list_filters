module ActiveScaffold::DataStructures
  class ListFilter
		include ActiveScaffold::Configurable
		
    # provides a quick way to set any property of the object from a hash
    def initialize(filter_name, core, options = {}, defaults = {})
      @name = filter_name
      @label = filter_name.to_s.humanize
			@core = core
			@options = options
			@filter_type = self.class.to_s.demodulize[0..-7].underscore
			@defaults = defaults
			@session = nil

      # apply quick properties
      options.each_pair do |k, v|
        setter = "#{k}="
        self.send(setter, v) if self.respond_to? setter
      end
    end

		attr_reader :filter_type
		attr_reader :name
		attr_reader :options
		attr_reader :core
		attr_reader :defaults
		
		def session=(session)
		  @session = session
	  end
		
		def params
		  return @session unless @session.nil?
		  return @defaults unless @defaults.nil?
		  nil
	  end

		def get_column(col)
			@core.columns.detect{|c| col.to_sym == c.name.to_sym }
		end
		
		def conditions(params)
			[]
		end

    # what string to use to represent this action
    attr_writer :label
    def label
      as_(@label)
    end

  end
end