module Extensions
  module Core
    # configures where the active_scaffold_list_filter plugin itself is located. there is no instance version of this.
    #cattr_accessor :list_filter_plugin_directory
    #@@list_filter_plugin_directory = File.expand_path(__FILE__).match(/vendor\/plugins\/([^\/]*)/)[1]
    
#     def self.list_filter_plugin_directory
#       File.expand_path(__FILE__).match(/vendor\/plugins\/([^\/]*)/)[1]
#     end
#     
#     # the active_scaffold_filter template path
#     def template_search_path_with_list_filter(frontend = self.frontend)
#       frontends_path = "../../vendor/plugins/#{ActiveScaffold::Config::Core.list_filter_plugin_directory}/frontends"
#       search_path = template_search_path_without_list_filter
#       search_path << "#{frontends_path}/#{frontend}/views" if frontend.to_sym != :default
#       search_path << "#{frontends_path}/default/views"
#       return search_path
#     end
# 		alias_method_chain :template_search_path, :list_filter
		
		ActionController::Resources::Resource::ACTIVE_SCAFFOLD_ROUTING[:collection][:list_filter] = :get
  end
end