# Utilities

A collection of useless scripts.

* ### tmux.sh

  * using TMUX, split window into different panels.
  * Usage
    * `./tmux.sh <number of panels> <optional command>`
  * Example
    * `./tmux.sh 8 ls`

* #### avatar/avatar.sh

  * display graphics
  * Usage
    * `./avatar.sh <filename without .txt>`
  * Example
    * `./avatar.sh darksouls`

* #### avatar/images/*.txt

  * The graphics files are under `data`
  * The first few lines define color
  * The next few lines represent pixels
    * 0,1,,,9 are the first 9 colors, a,,,z are the next 26 colors.
    * Example
      * `0a1b` will be an image of 4 pixels of color0, color10, color1, color11