require 'date'
require 'optparse'
require_relative './calendar.rb'

def read_config(config)
  OptionParser.new do |opts|
    opts.banner = "Usage: dzen2-calendar [options]"

    opts.on("--bg '#0E0D15'", "Set background color") do |color|
      config[:color0] = color
    end

    opts.on("--fg '#DDDDDD'", "Set foreground color") do |color|
      config[:color1] = color
    end

    opts.on("-x 1650", Integer, "X position") do |x|
      config[:x] = x
    end

    opts.on("-y 810", Integer, "Y position") do |y|
      config[:y] = y
    end

    opts.on("-w", "--width 26", Integer, "Set calendar width") do |width|
      config[:width] = width
    end

    opts.on("-s", "--screen 1", Integer, "Set screen on which the calendar is displayed") do |screen|
      config[:screen] = screen
    end

    opts.on("--year 1970", Integer, "Set the displayed year") do |year|
      config[:year] = year
    end

    opts.on("--month 2", Integer, "Set the displayed month") do |month|
      config[:month] = month
    end

    opts.on("--no-toggle", "Determine if a new calendar should be opened after closing the previous one") do
      config[:toggle] = false
    end
  end.parse!
  config
end

def open(config)
  content = "#{get_header(config)}#{get_body(config)}"
  dzen_string = <<END
    echo "#{get_title(config)}\n#{content}" | dzen2 \
      -title-name "calendar" \
      -bg "#{config[:color0]}" \
      -fg "#{config[:color1]}" \
      -x "#{config[:x]}" \
      -y "#{config[:y]}" \
      -h 30 \
      -l 7 \
      -w #{config[:width] * 10} \
      -tw #{config[:width] * 10} \
      -e "onstart=uncollapse;button3=exit" \
      -ta c \
      -sa l \
      -xs #{config[:screen]} \
      -fn mono \
      -p &
END
  exec(dzen_string)
end

def close
  `pkill -f "dzen2 -title-name calendar"`
  $?.exitstatus == 0
end
