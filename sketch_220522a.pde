import processing.serial.*;
import ddf.minim.*;
 
Serial myPort;
Minim minim;
AudioPlayer player;
AudioPlayer player_ad; 
AudioPlayer player_pr;
float oldGain = 0;
float oldGainAd = 0; 
int adTrigCount = 0;
int playPrev = 1;

 
void setup()
{
  // change next line based on your USB port name
  myPort = new Serial(this, "/dev/cu.usbmodem14201", 9600);
  minim = new Minim(this);
  player = minim.loadFile("boat1_music88_long.wav");
  player_ad = minim.loadFile("Boat1_desc.mp3"); 
  player_pr = minim.loadFile("boat1_preview.wav"); 
}

//I'm doing this in percent, but it may need to be in decibels; if not audible, try multiplying volume by 100
 float chooseVolume(float distance){
   //if (distance > 150) {
   //  return -100;
   //}
   //For keys 0cm to 150cm, values (in terms of gain, not decibels or percent) go from 0 to -10. 
   //"volume" is the value for the key "distance," which doesn't have to be under 150cm away (map extrapolates values for keys > 150) 
   float volume = map(distance, 0, 150, 0, -10); 
   oldGain = volume; 
   return volume;
 }
 
 //I'm doing this in percent, but it may need to be in decibels; if not audible, try multiplying volume by 100
 float chooseVolumeAd(float distance){
   float volume = map(distance, 0, 400, 0, -80); 
   oldGainAd = volume; 
   return volume;
 }
 
   
 //note: not sure what happens when distance is further than Arduino can pick up; does it stop playing automatically?
 //Otherwise, need to write code that stops it
 //if we get clicks, try using shiftVolume() instead of setVolume()
void draw() {
  while (myPort.available() > 0) {
    //If description is over, reset to beginning; it will need to be triggered again
    if (player_ad.position() == player_ad.length()){
      player_ad.pause();
      player_ad.rewind();
      adTrigCount = 0;
    }
    //set preview back to beginning once it has finished
    if (player_pr.position() == player_pr.length()){
      player_pr.pause();
      player_pr.rewind();
    }
    //restart music if it has ended
    if (player.position() == player.length()){
      player.rewind();
    }
    float inByte = myPort.read();
    //allow preview to be triggered again if user has gotten more than 170cm since the last time it played
    if ((playPrev == 0) && (inByte > 170)){
      playPrev = 1;
    }
    float vol = chooseVolume(inByte);
    //float volAd = chooseVolumeAd(inByte); 
    println(inByte);
    //250 milliseconds shift
    player.shiftGain(oldGain, vol, 400);
    player.play();
    //play preview if user is btwn 1.2 & 1.4m away
    //playPrev ensures preview can't be re-triggered until person gets over 170cm away and then comes back
    //also, can't play if full description is also playing
    if ((inByte > 120) && (inByte < 140) && (playPrev == 1) && (!player_ad.isPlaying())){
      playPrev = 0;
      player_pr.play();
    }
    if (inByte < 100) { // If user stands <=1m away from sensor for long enough, play full description 
      adTrigCount ++;
      if (adTrigCount >= 10){
        player_ad.setGain(20); 
        player_ad.play(); 
      }
    }

    //} else {
    //  //player_ad.shiftGain(oldGainAd, volAd, 1000);
    //  player_ad.pause();
    //}
  }
}
