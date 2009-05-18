module ActiveScaffold::Config
  class ListFilter < Base  
    self.crud_type = :read
    
    def initialize(core_config)
      @core = core_config

      # originates here
      @list_filters = ActiveScaffold::DataStructures::ListFilters.new()      
      setup_view_paths
    end

    # can't seem to alias method chain the active scaffold method, so just setup our view paths when we are config'ed!
    def setup_view_paths
      # add app/views/active_scaffold_list_filters to the view paths for custom filters
      ActionController::Base.view_paths.each do |dir|
        if File.exists?(File.join(dir,"active_scaffold_list_filters"))
          ActionController::Base.append_view_path(File.join(dir,"active_scaffold_list_filters")) 
        end
      end
      active_scaffold_default_frontend_path = File.join(Rails.root, 'vendor', 'plugins', File.expand_path(__FILE__).match(/vendor\/plugins\/([^\/]*)/)[1], 'frontends', 'default' , 'views')
      ActionController::Base.append_view_path(ActiveScaffoldPath.new(active_scaffold_default_frontend_path))
    end
    
    # global level configuration
    # --------------------------
    # the ActionLink for this action
    cattr_accessor :link
    @@link = ActiveScaffold::DataStructures::ActionLink.new('list_filter', :label => 'Filter', :type => :table, :security_method => :list_filter_authorized?)

    # instance-level configuration
    # ----------------------------
    attr_writer :link
    def link
			if @list_filters.length > 0
				self.class.link.clone
			end
    end
    
    # provides access to the list of columns specifically meant for the Table to use
    def columns
      self.columns = @core.columns._inheritable unless @columns # lazy evaluation
      @columns
    end
    def columns=(val)
      @columns = ActiveScaffold::DataStructures::ActionColumns.new(*val)
      @columns.action = self
    end

		def get_column(col)
			@columns.detect{|c| col.to_sym == c.name.to_sym }
		end
		
    # provides access to the list of filters
		attr_reader :filters
    def filters
      @list_filters
    end

    # Add a list filter
    def add(filter_type, filter_name, options = {}, defaults = {})
      @list_filters.add(filter_type, filter_name, @core, options, defaults)
    end
  end
end