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
      # This code doesn't work because #to_date is no longer defined for hashes
      # start_date = start_date.to_date
      # end_date = end_date.to_date

      start_date = Date.new(start_date["year"].to_i, start_date["month"].to_i, start_date["day"].to_i)
      end_date = Date.new(end_date["year"].to_i, end_date["month"].to_i, end_date["day"].to_i)

      return start_date, end_date
    rescue
      return nil, nil
    end
  end

end
