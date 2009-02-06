module ActiveScaffold::Actions
  module ListFilter
    def self.included(base)
      base.send :alias_method_chain, :joins_for_finder, :list_filters
      base.before_filter :list_filter_authorized?, :only => [:list_filter]
      base.before_filter :init_filter_session_var
	    base.before_filter :do_list_filter
    end
    
    def joins_for_finder_with_list_filters
      joins_for_finder_without_list_filters + joins_for_list_filter_finder
    end
      
    def joins_for_list_filter_finder
      joins = []
      active_scaffold_config.list_filter.filters.each do |filter|
        find_options = filter.find_options
        joins << find_options[:include] unless find_options.nil? || find_options[:include].nil?
      end
      joins
    end
    
      
    # todo, clean this up!!!
    def init_filter_session_var
      # check if how we're filtering
			if !params["list_filter"].nil?
				if params["list_filter"]["input"] == "filter"
			  	active_scaffold_session_storage["list_filter"] = params["list_filter"]
			  elsif params["list_filter"]["input"] == "save"
			    active_scaffold_session_storage["list_filter"] = params["list_filter"]
			    save_list_filter
				elsif params["list_filter"]["input"] == "reset"
					active_scaffold_session_storage["list_filter"] = nil
				end
			# if we aren't, then are we loading the filter, if not load the default
	    elsif params["action"] != "list_filter"
			  active_scaffold_session_storage["list_filter"] = load_list_filter(:default)
		  end
    end

    def list_filter
      # setup our view path
#       append_view_path "app/list_filters"
#       append_view_path "#{File.dirname(__FILE__)}/../../list_filters"
      filter_config = active_scaffold_config.list_filter
	    respond_to do |wants|
        wants.html do
          if successful?
            render(:partial => 'list_filter', :locals => { :filter_config => filter_config }, :layout => true)
          else
            return_to_main
          end
        end
        wants.js do
          render(:partial => 'list_filter', :locals => { :filter_config => filter_config }, :layout => false)
        end
      end
    end

    protected

    def do_list_filter
      # move to hook into these
      # self.active_scaffold_conditions = merge_conditions(self.active_scaffold_conditions, *search_conditions)
      # @filtered = !search_conditions.blank?
      # 
      # includes_for_search_columns = columns.collect{ |column| column.includes}.flatten.uniq.compact
      # self.active_scaffold_joins.concat includes_for_search_columns

    
      verbose_filter = []
      active_scaffold_config.list_filter.filters.each do |filter|
        filter_session = active_scaffold_session_storage["list_filter"] unless active_scaffold_session_storage["list_filter"].nil?
    		filter_session = filter_session[filter.filter_type] unless filter_session.nil?
    		filter_session = filter_session[filter.name] unless filter_session.nil?
        filter.session = filter_session
        
        find_options = filter.find_options
        conditions = find_options[:conditions] unless find_options.nil?
        
        self.active_scaffold_conditions = merge_conditions(self.active_scaffold_conditions, conditions)
        
        
        active_scaffold_config.list.user.page = nil
        verbose_filter << "#{filter.label} (#{filter.verbose})" unless filter.verbose.nil?
      end
      
      set_flash(verbose_filter)
    end
    
    def set_flash(verbose_filter)
      if flash[:info].nil?
        flash[:info] = ""
      end
      flashes = []
      flashes << "Searching on: #{params[:search]}" unless params[:search].nil? || params[:search] == ""
      flashes << "Filtering on: #{verbose_filter.join(', ')}" unless verbose_filter.empty?
      flash[:info] = flashes.join(" | ")
      if flash[:info] == ""
        flash[:info] = nil
      end
    end
    
    def save_list_filter
      return
      
      saved_filters = active_scaffold_config.list.user.db_load(:list_filter) || {}
      p = params[:list_filter]
      p.delete(:input)
      saved_filters[:default] = p
      active_scaffold_config.list.user.db_save(:list_filter, saved_filters)
    end

    def load_list_filter(filter)
      return {}
      
      saved_filters = active_scaffold_config.list.user.db_load(:list_filter) || {}
      return saved_filters[:default]
    end

		def clear_list_filter
				active_scaffold_session_storage[:list_filter] = nil?
				active_scaffold_config.list.user.page = nil
		end

    # The default security delegates to ActiveRecordPermissions.
    # You may override the method to customize.
    def list_filter_authorized?
      authorized_for?(:action => :read)
    end
  end
end