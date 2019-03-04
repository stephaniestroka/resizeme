# resizeme

A simple script for resizing all images in a given directory and setting their quality based on [ImageMagick](https://www.imagemagick.org/).

## Requirements

The script assumes that you have ImageMagick installed on your computer.
You can download it from [their website](https://www.imagemagick.org/script/download.php) or install it using brew (`brew install imagemagick`), dnf, apt-get or whatever package manager is running on your system.

## Options

Once you have ImageMagick, check out the available options:

```text
bash-4.4$ ./resizeme.sh -h

The following commands are available:

-i / --input:   The input directory is recursively searched for image files.
-o / --output:  The output directory is used to store the converted images.
-w / --width:   The width to which the image should be resized. The height is resized according to the images aspect ratio.
-q / --quality: The quality of the image. Values allowed are in between 1 and 100. The better the quality, the lower the compression.
-a / --adaptive-resize: Instead of using regular resize, use adaptive resize (see 'man convert').
-h / --help:    Prints this message.
```
