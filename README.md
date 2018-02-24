# resizeme
A simple script for resizing images and settings their quality. Based on imagemagick.

# HowTo

The script is based on imagemagick and assumes that you already have it running on your computer.
You can get it [here](https://www.imagemagick.org/script/download.php) or install it using brew, dnf, apt-get or whatever package manager is running on your system.

Once you have imagemagick, check out the available options:
```
bash-4.4$ ./resizeme.sh -h

The following commands are available: 

-i / --input:   The input directory is recursively searched for image files.
-o / --output:  The output directory is used to store the converted images.
-w / --width:   The width to which the image should be resized. The height is resized according to the images aspect ratio.
-q / --quality: The quality of the image. Values allowed are in between 1 and 100. The better the quality, the lower the compression.
-a / --adaptive-resize: Instead of using regular resize, use adaptive resize (see 'man convert').
-h / --help:    Prints this message.
```
