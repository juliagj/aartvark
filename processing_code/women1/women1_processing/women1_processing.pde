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
float timeAway = 0;
int hasLeft = 0;
float startTime = 0;
int pause = 0;
int hasPlayed = 0;

 
void setup()
{
  // change next line based on your USB port name
  myPort = new Serial(this, "/dev/cu.usbmodem14201", 9600);
  minim = new Minim(this);
  player = minim.loadFile("../women1_music34.mp3");
  player_ad = minim.loadFile("../Women1_desc.mp3"); 
  player_pr = minim.loadFile("../women1_preview.wav"); 
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
  //println(player.length());
  while (myPort.available() > 0) {
    println(player.position()); 
    
    float inByte = myPort.read();
    String manControl = myPort.readString();
    println(manControl);
    //If description is over, reset to beginning; it will need to be triggered again
    
    //restart music if it has ended
    if (!player.isPlaying() && (inByte < 200)){
      println("music ended"); 
      println("player_pr rewinding"); 
      player.rewind();
      player.play();
    }
    
    //float manControl = myPort.read();
    //allow preview to be triggered again if user has gotten more than 170cm since the last time it played
    if ((playPrev == 0) && (inByte > 170)){
      playPrev = 1;
    }
    
    if (!player_ad.isPlaying()){
      println("got to not playing part"); 
      if (manControl != null && manControl.equals("y")){
        player_ad.play();
        pause = 0;
      }
    }
    
    if (player_ad.isPlaying()){
      //if hasLeft is 0 and they are far away, switch hasLeft to 1 and start timer 
      println("got to playing part"); 
      if (manControl != null && manControl.equals("e")) {
        pause = 1;
        player_ad.pause();
      }
      if ((hasLeft == 0) && (inByte > 170)){
        hasLeft = 1;
        hasPlayed = 0;
        adTrigCount = 0; 
        startTime = millis();
      } 
      if ((millis() - startTime) >= 5000 && inByte > 170) {
        player_ad.rewind();
        player_ad.pause();
      }
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
    if ((inByte > 110) && (inByte < 150) && (playPrev == 1) && (!player_ad.isPlaying()) && (pause == 0)){
      playPrev = 0;
      hasPlayed = 1;
      player_pr.play();
    }
    if (inByte < 100) { // If user stands <=1m away from sensor for long enough, play full description 
      hasLeft = 0;
      adTrigCount++;
      if (hasPlayed == 0){
        player_pr.play();
        hasPlayed = 1;
      } else if ((adTrigCount >= 5) && (pause == 0) && (!player_pr.isPlaying()) && (hasPlayed == 1) ){
        player_ad.setGain(20); 
        player_ad.play(); 
      }
    }

  }
}
