class ListFilters::AssociationFilter < ActiveScaffold::DataStructures::ListFilter

  # Return a list of conditions based on the params 
  def find_options
    begin
      assocation = @core.model.reflect_on_association(assocation_name)
      options = {}
      options[:include] = assocation_name
      options[:conditions] = ["#{assocation.klass.table_name}.id IN (?)", params]

      return options           
  	end unless params.nil? || params.empty?
  end
  
  def verbose
    begin
  	  ar_class = association_tree.last.class_name.constantize
    	associated_values = ar_class.find(params).sort {|a,b| a.to_label <=> b.to_label }
    	verbose_values = associated_values.collect{|av| av.to_label}.join(", ")
    	return verbose_values
    end unless params.nil? || params.empty?
  end
  
  def assocation_name
    @options[:association] || @name
  end
	
end
