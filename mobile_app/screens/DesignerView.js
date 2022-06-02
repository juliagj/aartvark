import { StatusBar } from 'expo-status-bar';
import React, { useState, useEffect } from 'react';
import { StyleSheet, Text, View} from 'react-native';
import { IconButton, Button, Colors, Title } from 'react-native-paper';

import Firebase from '../config/firebase.js';
import { getDatabase, ref, onValue } from 'firebase/database';

export default function DesignerView(props) {
    const [status, showStatus] = useState(null); // initial status is pause, changing into play now...

    useEffect(() => {
        const db = getDatabase();
        const reference = ref(db, 'users/viewer');
        onValue(reference, (snapshot) => {
            showStatus(snapshot.val());
        });
      });

  return (
      <View style={styles.container}>
          <Title>Viewer wants to {status} audio description.</Title>
        <Button 
            mode="contained" 
            color={Colors.grey800} 
            style={styles.backButton}
            onPress={() => props.updateScreen(null)}>
            Back
        </Button>
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
