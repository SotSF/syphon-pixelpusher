# syphon-pixelpusher

This is an integration with [Syphon](syphon.v002.info/) (which is sadly mac-only tech) with Pixel Pusher.

## forwarder

This is a processing script that creates a Syphon client and uses it to render and sample from the Syphon client's stream.

Requirements:

* Processing 3+
* pixel pusher Processing library
* syphon Processing library
* Some syphon server

For example, you can use [VLCSyphon](https://github.com/rsodre/VLCSyphon) to play a video, then run this processing script to render it to pixel pushers on the network.
