# GaiaTouch installation touchboard

In this folder you can find the code, design and voice samples used in the
installation

* design
> Simple dxf design of the touchboard made in LibreCAD.
* firmware
> The code running on the Bare Conductive Arduino Touch Board. It handles the
> input, the leds and the playback of the voice samples. It acts as a keyboard,
> sending keypresses to the Raspeberry Pi running the GaiaTouch webpage from the
> eleven touch icons on the board. It controls 8 4xWS2812 5050 RGB LED Squares
> to indicate the active option on the board and plays a predefined voice sample
> on touch. To build and use it, you will need the libraries provided by Bare
> Conductive and version 1.6.5 of Arduino libraries.
* voices
> The script used to generate the voice samples for the installation. It
> requires espeak and ffmpeg to generate the MP3 files. To use them, copy the
> files to the SD card provided with the Arduino Touch Board. Refer to the
> script for information on how to change the voice. Using the script as is
> will generate the voices used in the demo.
