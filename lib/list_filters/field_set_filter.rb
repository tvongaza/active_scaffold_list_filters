class ListFilters::FieldSetFilter < ActiveScaffold::DataStructures::ListFilter
  
  def find_options
    begin
      options = {}
      options[:conditions] = ["#{field_name.to_s} IN (?)", params]
      return options
    end unless params.blank?
  end
  
  def verbose
    return params.join(", ") unless params.blank?
  end
  
  def field_name
    @name
  end
  
  def values
    options[:values] || []
  end
  
end