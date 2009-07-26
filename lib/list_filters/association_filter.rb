class ListFilters::AssociationFilter < ActiveScaffold::DataStructures::ListFilter

  # Return a list of conditions based on the params 
  def find_options
    begin
      association = association_class
      options = {}
      options[:include] = association_name
      options[:conditions] = ["#{association.table_name}.id IN (?)", params]

      return options      
    end unless params.nil? || params.empty?
  end

  def verbose
    begin
      ar_class = association_class
      associated_values = ar_class.find(params).sort {|a,b| a.to_label <=> b.to_label }
      verbose_values = associated_values.collect{|av| av.to_label}.join(", ")
      return verbose_values
    end unless params.nil? || params.empty?
  end

  def association_name
    @options[:association] || @name
  end

  def association_class
    association = @core.model.reflect_on_association(association_name)
    association.klass
  end
end
