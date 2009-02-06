class ListFilters::DateFilter < ActiveScaffold::DataStructures::ListFilter

	# Return a list of conditions based on the params 
	def find_options
	  start_date, end_date = parse_dates(params[:start_date], params[:end_date])
	  if start_date && end_date
      column = @options[:column] || @name
      return :conditions => ["#{@core.model.table_name}.#{column} BETWEEN ? AND ?", start_date, end_date]
	  end
	end
	
  def verbose
	  start_date, end_date = parse_dates(params[:start_date], params[:end_date])
    if start_date && end_date
      "between #{start_date} and #{end_date}"
    end
  end
  
  def parse_dates(start_date, end_date)
    begin
      start_date = start_date.to_date
      end_date = end_date.to_date
      return start_date, end_date
    rescue
      return nil, nil
    end
  end
	
end