STRATEGY_TOKEN = {'dollar' => " $ ", 'percent' => " % "}.freeze

class ParserService
  def initialize(text, strategy)
    @separator = STRATEGY_TOKEN[strategy]
    @text = text
    @rows = rows
    @header = header
  end

  def rows
    @rows ||= @text.split("\n")[1..].map { |row| row.split(@separator) }
  end

  def header
    @header ||= @text.split("\n")[0]
                     .split(@separator)
  end
end
