# meta-metapixel
Meta-metapixel is a simple bash script that helps you create video photomosaics in the style of Down The Meta Hole ( https://vimeo.com/36232673 )

Simply run the script as:
```
./meta-metapixel.sh filename.avi
```

With default settings meta-metapixel will output a video with a resolution roughly 3 times the width and height of the original footage (parameter -s 3 when metapixel is called). You can also maintain the scaling but specify a different resolution for the output video by appending to mencoder -vf scale=width:height. For instance appending to the call to mencoder:

```
 -vf scale=$x:$y
```
will output a video with the same resolution of the original file.

##Installation notes:

In order to run meta-metapixel you need to have installed on your system the following packages:

* metapixel
* mencoder
* ffmpeg

on Ubuntu simply run:
```
sudo apt-get install metapixel mencoder ffmpeg
```
and you should be good to go. If you have an outdated version of Ubuntu you will probably face the the ffmpeg in-and-out clusterfuck and you may have to compile ffmpeg from source. But on a modern version you should be fine. Thank Ubuntu. Thubuntu.
