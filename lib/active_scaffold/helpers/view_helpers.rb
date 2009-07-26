module ActiveScaffold
  module Helpers::ViewHelpers

  # Add the export plugin includes
  def active_scaffold_includes_with_list_filter(frontend = :default)
    css = stylesheet_link_tag(ActiveScaffold::Config::Core.asset_path('list_filter-stylesheet.css', frontend))
    ie_css = stylesheet_link_tag(ActiveScaffold::Config::Core.asset_path("list_filter-stylesheet-ie.css", frontend))
    active_scaffold_includes_without_list_filter + "\n" + css + "\n<!--[if IE]>" + ie_css + "<![endif]-->\n"
  end
  alias_method_chain :active_scaffold_includes, :list_filter
  end
end
