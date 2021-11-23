class PeopleController
  def initialize(params)
    @params = params
    @order = params[:order]
    @parser = ParserService
    @data_manager = DataManager

    parse_dollar_format
    parse_percent_format
    combine_data
  end

  def parse_dollar_format
    @dollar_format ||= @parser.new(@params[:dollar_format], "dollar")
  end

  def parse_percent_format
    @percent_format ||= @parser.new(@params[:percent_format], "percent")
  end

  def combine_data
    @dollar_data ||= @data_manager.new(@dollar_format)
                                .format_by_column(:city, method(:format_city))
                                .save!
    @percent_data ||= @data_manager.new(@percent_format)
    @data ||= @percent_data.merge(@dollar_data)
  end

  def normalize
    @data.by_columns(:first_name, :city, :birthdate)
         .sort_by(:first_name)
         .format_by_column(:birthdate, method(:format_birthdate))
         .normalize
         .cursor
  end

end
