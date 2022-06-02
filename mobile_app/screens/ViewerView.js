import { setStatusBarStyle, StatusBar } from 'expo-status-bar';
import React, { useState, useEffect } from 'react';
import { StyleSheet, Text, View} from 'react-native';
import { IconButton, Button, Colors } from 'react-native-paper';

import { Audio } from 'expo-av';

import Firebase from '../config/firebase.js'
import { getDatabase, ref, onValue, set } from 'firebase/database';

export default function ViewerView(props) {
  
  const [status, setStatus] = useState(null); // initial status is pause, changing into play now...

  useEffect(() => {
    const db = getDatabase();
    const reference = ref(db, 'users/viewer');
    onValue(reference, (snapshot) => {
        setStatus(snapshot.val());
    });
  });

  function storeStatus(statusUpdate) {
    const db = getDatabase();
    const reference = ref(db, 'users/viewer');
    set(reference, statusUpdate);
    setStatus(statusUpdate);
  }

  const [sound, setSound] = useState();

  async function playSound() {
    console.log('Loading Sound');
    
    const { sound } = await Audio.Sound.createAsync(
      status === 'pause' 
      ? require('../resources/play.wav')
      : require('../resources/pause.wav')
    );
    setSound(sound);
    console.log('Playing Sound');
    await sound.playAsync(); }

  useEffect(() => {
    return sound
      ? () => {
          console.log('Unloading Sound');
          sound.unloadAsync(); }
      : undefined;
  }, [sound]);

  function changeStatus(){
    if (status == 'pause') {
      playSound();
      storeStatus('play');
    } else if (status == 'play'){
      playSound();
      storeStatus('pause');
    } 
  }

  return (
      <View style={styles.container}>
        {
          status === 'play'  ?  // when sound is playing, show the pause button.
          <IconButton
            icon="pause-circle"
            color={Colors.grey800}
            size={280}
            onPress={() => changeStatus()} //on press, pause the music!
          /> :
          <IconButton
            icon="play-circle"
            color={Colors.grey800}
            size={280}
            onPress={() => changeStatus()}
          />   
        }

        <Button 
            mode="contained" 
            color={Colors.grey800} 
            style={styles.backButton}
            onPress={() => props.updateScreen(null)}>
            Back
        </Button>
        <StatusBar style="auto" />
      </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
  backButton: {
    position: 'absolute',
    top: 50
  }
});
