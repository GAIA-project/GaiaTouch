#include <MPR121.h>
#include <Wire.h>

#include <SPI.h>
#include <SdFat.h>
#include <FreeStack.h>
#include <SFEMP3Shield.h>

#include <FastLED.h>

SdFat sd;
SFEMP3Shield MP3player;

#define countof(x) (sizeof(x)/sizeof(x)[0])

#define numElectrodes 12
#define touch_tempr 0
#define touch_noise 1
#define touch_humid 2
#define touch_pwcon 3
#define touch_daily 4
#define touch_weekl 5
#define touch_cmpr  6
#define touch_cnxt  7
#define touch_gaia  8
#define touch_magic 9
#define touch_next  10
#define touch_prvs  11

#define NUM_LEDS 32
#define BRN_LEDS 5

unsigned long int leds_clrs[10] = {
  0xcc0000,
  0x75507b,
  0x3465a4,
  0xc17d11,

  0x000075,
  0xf57900,
  0x808000,
  0x808080,

  0x9CC900,
  0x000000
};
CRGB leds[NUM_LEDS];

int keys[12] = {
  's',
  'd',
  'f',
  'g',

  'q',
  'w',
  'e',
  '1',

  KEY_F5,
  KEY_LEFT_CTRL,

  'a',
  'z'
};

char audio[12][12] = {
  "temp.mp3",
  "db.mp3",
  "humi.mp3",
  "pc.mp3",

  "daily.mp3",
  "weekly.mp3",
  "comp.mp3",
  "next.mp3",

  "gaia.mp3",
  "bell.mp3",

  "next.mp3",
  "prev.mp3",
};

int leds_brtnss = BRN_LEDS;

int phnm_prvs = 0;

bool cmpr_enbld = false;
int  cmpr_prvs = 0;

void leds_close(int i) {
  for(int l = i*4/(NUM_LEDS/2)*(NUM_LEDS/2); l < (i*4/(NUM_LEDS/2)+1)*(NUM_LEDS/2); l++) {
    leds[l] = leds_clrs[9];
  }
}

void leds_open(int i, unsigned long int c) {
  for(int l = i*4; l < (i+1)*4; l++) {
    leds[l] = leds_clrs[c];
  }
}

void leds_close() {
  leds_close(0);
  leds_close(4);
}

void leds_loop() {
  for(int j = 0; j < NUM_LEDS/2; j++){
    leds[j] = leds_clrs[8];
    leds[j+NUM_LEDS/2] = leds_clrs[8];
    FastLED.show();
    delay(110);
  }
  for(int j = NUM_LEDS/2; j > 0; j--){
    leds[j-1] = leds_clrs[9];
    leds[j-1+NUM_LEDS/2] = leds_clrs[9];
    FastLED.show();
    delay(110);
  }
}

void setup()
{
  Wire.begin();
  Keyboard.begin();

  // 0x5C is the MPR121 I2C address on the Bare Touch Board
  if(!MPR121.begin(0x5C)) while(1);
  // pin 4 is the MPR121 interrupt on the Bare Touch Board
  MPR121.setInterruptPin(4);
  // this is the touch threshold - setting it low makes it more like a proximity trigger
  // default value is 40 for touch
  //MPR121.setTouchThreshold(2);
  // this is the release threshold - must ALWAYS be smaller than the touch threshold
  // default value is 20 for touch
  //MPR121.setReleaseThreshold(1);
  // initial data update
  MPR121.updateTouchData();

  if(!sd.begin(SD_SEL, SPI_HALF_SPEED)) sd.initErrorHalt();

  MP3player.begin();
  MP3player.setVolume(10,10);

  FastLED.addLeds<NEOPIXEL, 13>(leds, NUM_LEDS);
  FastLED.setBrightness(leds_brtnss);
  leds_loop();
  FastLED.show();
}

void loop()
{
  if(MPR121.touchStatusChanged()) {
    MPR121.updateTouchData();
    for(int i=0; i<numElectrodes; i++) {
      if(MPR121.isNewTouch(i)) {
        switch(i) {
          case touch_tempr:
          case touch_noise:
          case touch_humid:
          case touch_pwcon: {
            MP3player.stopTrack();
            MP3player.playMP3(audio[i]);
            Keyboard.press(keys[i]);
            Keyboard.releaseAll();
            leds_close(i);
            leds_open(i, 8);
            FastLED.show();
            phnm_prvs = i;
            break;
          }
          case touch_daily:
          case touch_weekl: {
            MP3player.stopTrack();
            MP3player.playMP3(audio[i]);
            Keyboard.press(keys[i]);
            Keyboard.releaseAll();
            Keyboard.press(keys[phnm_prvs]);
            Keyboard.releaseAll();
            leds_close(i);
            leds_open(i, 8);
            FastLED.show();
            cmpr_enbld = false;
            break;
          }
          case touch_cmpr: {
            MP3player.stopTrack();
            MP3player.playMP3(audio[i]);
            Keyboard.press(keys[i]);
            Keyboard.releaseAll();
            leds_close(i);
            leds_open(i, 8);
            Keyboard.press(keys[i+1]+cmpr_prvs);
            Keyboard.releaseAll();
            leds_open(i+1, cmpr_prvs);
            FastLED.show();
            cmpr_enbld = true;
            break;
          }
          case touch_cnxt: {
            if(cmpr_enbld) {
              MP3player.stopTrack();
              MP3player.playMP3(audio[i]);
              if(++cmpr_prvs > 7) cmpr_prvs = 0;
              Keyboard.press(keys[i]+cmpr_prvs);
              Keyboard.releaseAll();
              leds_open(i, cmpr_prvs);
              FastLED.show();
            }
            break;
          }
          case touch_gaia: {
            Keyboard.press(keys[i+1]);
            Keyboard.press(keys[i]);
            Keyboard.releaseAll();
            leds_close();
            FastLED.show();
            leds_loop();
            MP3player.stopTrack();
            MP3player.playMP3(audio[i]);
            leds_loop();
            phnm_prvs = 0;
            cmpr_enbld = false;
            MPR121.stop();
            delay(500);
            if(!MPR121.begin(0x5C)) while(1);
            Keyboard.press(keys[touch_daily]);
            Keyboard.releaseAll();
            Keyboard.press(keys[touch_tempr]);
            Keyboard.releaseAll();
            leds_open(touch_tempr, 8);
            leds_open(touch_daily, 8);
            FastLED.show();
            break;
          }
          case touch_magic: {
            MP3player.stopTrack();
            MP3player.playMP3(audio[i]);
            leds_brtnss += 25;
            if(leds_brtnss > 255) leds_brtnss = BRN_LEDS;
            FastLED.setBrightness(leds_brtnss);
            FastLED.show();
            break;
          }
          case touch_next:
          case touch_prvs: {
            MP3player.stopTrack();
            MP3player.playMP3(audio[i]);
            Keyboard.press(keys[i]);
            Keyboard.releaseAll();
            break;
          }
          default:
            break;
        }
      } else
      if(MPR121.isNewRelease(i)) {
      }
    }
  }
}
