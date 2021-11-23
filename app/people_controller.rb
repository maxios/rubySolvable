class PeopleController
  def initialize(params)
    @params = params
    @order = params[:order]
    @parser = ParserService
    @data_manager = DataManager

    extract_dollar_format
    extract_percent_format
    combine_data
  end

  def extract_dollar_format
    @dollar_format ||= @parser.new(params[:dollar_format], "dollar")
  end

  def extract_percent_format
    @percent_format ||= @parser.new(params[:percent_format], "percent")
  end

  def combined_headers
    @dollar_format.header | @percent_format.header
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
  end

  private

  attr_reader :params
end
