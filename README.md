# noita-gif-generator
Quick and dirty script for generating gifs using an XML file with animation data.

# Usage
`./generate_gif path-to-xml-file`

or

`bash generate_gif.sh path-to-xml-file`

# Example
``` bash
x@x:~/.../LocalLow/Nolla_Games_Noita$ bash generate_gif.sh data/items_gfx/spell_refresh.xml 

data/items_gfx/spell_refresh.xml was found, proceeding
default
number of animations: 1
initial x: 0
initial y: 0
width: 20
height: 20
number of frames: 4
frame wait: 0.12
delay between frames [ms]: 12.00
path to image: data/items_gfx/spell_refresh.png
generating frames
generating gif
removing temporary files
```

# Errors
If you have an old version of Imagemagick, you might need to replace the 2 instances of `magick` to `convert`.
