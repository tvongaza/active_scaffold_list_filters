# load all our files, eventually figure out how to get these to load by themselves by convention
$:.unshift(File.dirname(__FILE__))

require "#{File.dirname(__FILE__)}/lib/helpers/view_helpers.rb"
require "#{File.dirname(__FILE__)}/lib/active_scaffold/helpers/view_helpers.rb"

ActiveScaffold::Config::Core.send(:include, Extensions::Core)
ActionView::Base.send(:include, Helpers::ViewHelpers)


#Kernel::load 'lib/pluginfactory.rb'
#Kernel::load 'lib/actions/list_filter.rb'


# Kernel::load 'lib/config/list_filter.rb'
# Kernel::load 'lib/data_structures/list_filter.rb'
# Kernel::load 'lib/data_structures/list_filters.rb'


#ActionController::Base.send(:include, ActiveScaffold)
#ActionController::Base.send(:include, Extensions::Finder)
#ActionController::Base..eval {include Extensions::Finder}


# # custom filters
# #Kernel::load 'lib/list_filters/base.rb'
# #Kernel::load 'lib/list_filters/association.rb'
