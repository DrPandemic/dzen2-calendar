# dzen2-calendar
A small calendar widget written in ruby strongly inspired by https://github.com/Iambecomeroot/dotfiles

![image](https://user-images.githubusercontent.com/3250155/40330024-a57abf1a-5d19-11e8-8bbd-41c0d76f1656.png)

## Requirements
- X
- ruby
- dzen2

## Usage
There's many optional arguments that can be passed to customize its behavior.
```
Usage: dzen2-calendar [options]
        --bg '#0E0D15'               Set background color
        --fg '#DDDDDD'               Set foreground color
        -x 1650                      X position
        -y 810                       Y position
        -w, --width 26               Set calendar width
        -s, --screen 1               Set screen on which the calendar is displayed
        --year 1970                  Set the displayed year
        --month 2                    Set the displayed month
        --no-toggle                  Determine if a new calendar should be opened after closing the previous one
```
