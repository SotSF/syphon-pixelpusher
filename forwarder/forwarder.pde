PGraphics canvas;

// Syphon
import codeanticode.syphon.*;
SyphonClient client;

// PixelPusher
import com.heroicrobot.dropbit.registry.*;
import com.heroicrobot.dropbit.devices.pixelpusher.Pixel;
import com.heroicrobot.dropbit.devices.pixelpusher.Strip;
import java.util.*;
PPObserver observer;
DeviceRegistry registry;

// Constants
int NUM_STRIPS = 96;
int NUM_LEDS_PER_STRIP = 75;
int FRAME_RATE = 30;

//Strip[] ledstrips = new Strip[NUM_STRIPS];

public void setup() {
  size(480, 340, P3D);

  frameRate(FRAME_RATE);

  // PixelPusher Stuff
  registry = new DeviceRegistry();
  registry.setAutoThrottle(true);
  registry.startPushing();
  observer = new PPObserver();
  registry.addObserver(observer);

  // Syphon Stuff
  println("Available Syphon servers:");
  println(SyphonClient.listServers());

  client = new SyphonClient(this);
  background(0);
}


public void draw() {
  if (client.newFrame()) {
    canvas = client.getGraphics(canvas);
    image(canvas, 0, 0, width, height);
    if (observer.hasStrips) {
      int stripy = 0;
      List<Strip> strips = registry.getStrips();
      int yscale = height / strips.size();
      for(Strip strip : strips) {
        int xscale = width / strip.getLength();
        Pixel[] pixels = new Pixel[strip.getLength()];
        for (int stripx = 0; stripx < strip.getLength(); stripx++) {
          pixels[stripx] = new Pixel(get(stripx*xscale, stripy * yscale));
        }
        strip.setPixels(pixels);
        stripy++;
      }
      // push pixelz
      // We can convert components of the color to bytes in this way if we ever need to:
      // byte red = (byte)(c >> 16 & 0xFF);
      // byte green = (byte)(c >> 8 & 0xFF);
      // byte blue = (byte)(c & 0xFF);
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    client.stop();
  } else if (key == 'd') {
    println(client.getServerName());
  }
}

class PPObserver implements Observer {
  public boolean hasStrips = false;
    public void update(Observable registry, Object updatedDevice) {
      this.hasStrips = true;
    }
}