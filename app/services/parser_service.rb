STRATEGY_TOKEN = {'dollar' => " $ ", 'percent' => " % "}.freeze

class ParserService
  attr_reader :rows, :header

  def initialize(text, strategy)
    @separator = STRATEGY_TOKEN[strategy]
    @text = text
    parse_rows
    parse_header
  end

  def parse_rows
    @rows ||= @text.split("\n")[1..].map { |row| row.split(@separator) }
  end

  def parse_header
    @header ||= @text.split("\n")[0]
                     .split(@separator)
  end
end
