require 'date'
require './calendar.rb'

config = {
  color0: '#0E0D15',
  color1: '#DDDDDD',
  x: -250,
  y: 840,
  screen: 1,
  width: 24,
  date: DateTime.now.to_date,
}

def get_content(config)
  "#{get_title(config)}\n#{get_header(config)}#{get_body(config)}"
end

def open(config)
  dzen_string = <<END
    echo "#{get_content(config)}" | dzen2 \
      -title-name "calendar" \
      -bg "#{config[:color0]}" \
      -fg "#{config[:color1]}" \
      -x "#{config[:x]}" \
      -y "#{config[:y]}" \
      -h 30 \
      -l 6 \
      -w #{config[:width] * 10} \
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

return if close
open(config)
