module Extensions
  module Core
    ActionController::Resources::Resource::ACTIVE_SCAFFOLD_ROUTING[:collection][:list_filter] = :get
  end
end
