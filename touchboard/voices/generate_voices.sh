#!/bin/sh

# Generates the voices for the touchboard.
# By default generates a female voice, to change it edit the espeak
# command's -v and -s options.

voice_lines=(
    "Temperature"
    "Noise Levels"
    "Relative Humidity"
    "Power Consumption"
    "Daily Data"
    "Weekly Data"
    "School Comparison"
    "Ping!"
    "Gaia, Green Awareness In Action"
    "Next School"
    "Previous School"
)

titles=(
  "temp"
  "db"
  "humi"
  "pc"
  "daily"
  "weekly"
  "comp"
  "bell"
  "gaia"
  "next"
  "prev"
)

for ((i=0;i<${#titles[@]};++i)); do
    rm "${titles[i]}".mp3
    espeak -ven-us+f4 -s170 -a 200 -g 10 --stdout "${voice_lines[i]}" | \
        ffmpeg -i pipe: -codec:a libmp3lame -qscale:a 0 "${titles[i]}".mp3
done