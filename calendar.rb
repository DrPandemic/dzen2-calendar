require 'date'
require 'pry'

class Cell
  def initialize(content, config, highligh = false)
    @content = content
    @highligh = highligh
    @width = config[:width]
  end

  def formatted(i)
    width = @width / 7 - @content.size
    left_padding(width, i) + @content + right_padding(width) + line_return(i)
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
  "<   #{config[:date].strftime('%B')} #{config[:date].year}   >"
end

def get_header(config)
  %w(Su Mo Tu We Th Fr Sa).map.with_index{ |d, i| Cell.new(d, config).formatted(i) }.join('')
end

def get_body(config)
  date = config[:date]
  width = config[:width]
  dates = (1..days_in_month(date)).map { |d| create_cell(d, config) }.to_a
  cells = (1..Date.new(date.year, date.month, 1).wday).map { || Cell.new('', config) } + dates
  format_body(cells, width)
end

def days_in_month(date)
  Date.new(date.year, date.month, -1).day
end

def create_cell(day, config)
  date = Date.new(config[:date].year, config[:date].month, day)
  Cell.new(day.to_s, config, DateTime.now == date)
end

def format_body(days, width)
  days.map.with_index { |d, i| d.formatted(i) }.join('')
end
