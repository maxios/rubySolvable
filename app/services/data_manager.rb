class DataManager
  attr_reader :header, :rows
  def initialize(data)
    @header = data.header.map &:to_sym
    @rows = data.rows
    @cursor = @rows
  end

  def by_columns(*cols)
    data = []
    cols.each { |col|  data << by_column(col) }
    @cursor = data.transpose
    self
  end

  def by_column(column)
    column_index = @header.index(column)

    @rows.map { |row| row[column_index] }
  end

  def sort_by(order)
    column_index = @header.index(order)

    @cursor.sort! { |a, b| a[column_index] <=> b[column_index] }
    self
  end

  def remove_column(name)
    column_index = @header.index(name)

    @header.delete_at(column_index)
    @rows.each { |row| row.delete_at(column_index) }
  end

  def merge(data)
    additional_header = data.header - @header
    @header.concat additional_header.map &:to_sym

    additional_data = []
    @header.each { |h| additional_data << data.by_column(h) }
    additional_data = additional_data.transpose
    @rows.concat additional_data
    self
  end

  def format_by_column(column, block)
    column_index = @header.index(column)

    @cursor.map! do |row|
      row[column_index] = block.call(row[column_index])
      row
    end
    self
  end

  def normalize
    @cursor.map do |row|
      row.join(', ')
    end
  end

  def save!
    @rows = @cursor
    @cursor = []
    self
  end
end

