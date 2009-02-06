class ListFilters::AssociationFilter < ActiveScaffold::DataStructures::ListFilter

  # Return a list of conditions based on the params 
  def find_options
    begin
      assocation = @core.model.reflect_on_association(assocation_name)
      options = {}
      options[:include] = assocation_name
      options[:conditions] = ["#{assocation.klass.table_name}.id IN (?)", params]

      return options           
#   		association = association_tree[association_tree.size - 1]
#   		column = [association.active_record.table_name, association.primary_key_name].join('.')
#   		return ["#{column} IN (?)", params]
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
  
  def association_tree
    association = @options[:association] || [@name]
  	arr ||= association_tree_from_array(@core.model, association).reverse
  	return arr
  end
  
  private
  
  def association_tree_from_array(model, association_array)
  	arr = []
  	association_array.each do |model_name|
  		#association = model.reflect_on_all_associations.detect {|assoc| assoc.name.to_s == model_name.to_s}
  		association = model.reflect_on_association(model_name)
  		arr << association
  		model = association.klass
  	end
  	return arr.reverse
  end
	
end
