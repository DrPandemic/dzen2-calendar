require 'date'
require 'pry'

class Cell
  def initialize(content, config, highlight = false)
    @content = content
    @highlight = highlight
    @width = config[:width]
    @color0 = config[:color0]
    @color1 = config[:color1]
  end

  def content
    return @content unless @highlight
    "^fg(#{@color0})^bg(#{@color1})#{@content}^fg()^bg()"
  end

  def formatted(i)
    width = @width / 7 - @content.size
    left_padding(width, i) + content + right_padding(width) + line_return(i)
  end

  def left_padding(width, i)
    if i % 7 == 0
      ' ' * ((@width % 7) / 2)
    else
      ''
    end + (' ' * (width / 2 + width % 2))
  end

  def right_padding(width)
    (' ' * (width / 2))
  end

  def line_return(i)
    ((i % 7) == 6 ? "\n" : '')
  end
end

def get_title(config)
    "<   #{Date.new(config[:year], config[:month], 1).strftime('%B')} #{config[:year]}   >"
end

def get_header(config)
  %w(Su Mo Tu We Th Fr Sa).map.with_index{ |d, i| Cell.new(d, config).formatted(i) }.join('')
end

def get_body(config)
  width = config[:width]
  dates = (1..days_in_month(config)).map { |d| create_cell(d, config) }.to_a
  cells = (1..Date.new(config[:year], config[:month], 1).wday).map { || Cell.new('', config) } + dates
  format_body(cells, width)
end

def days_in_month(config)
  Date.new(config[:year], config[:month], -1).day
end

def create_cell(day, config)
  date = Date.new(config[:year], config[:month], day)
  Cell.new(day.to_s, config, DateTime.now.to_date == date)
end

def format_body(days, width)
  days.map.with_index { |d, i| d.formatted(i) }.join('')
end
