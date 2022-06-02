import { StatusBar } from 'expo-status-bar';
import React, { useState, useEffect } from 'react';
import { StyleSheet, Text, View} from 'react-native';
import { IconButton, Colors } from 'react-native-paper';

import { Audio } from 'expo-av';
import ChooseView from './screens/ChooseView'
import ViewerView from './screens/ViewerView'
import DesignerView from './screens/DesignerView'

export default function App() {
  const [userType, setUserType] = useState(null); // null, viewer, designer

  function updateScreen(userType) {
    setUserType(userType);
  }

  return (
      <View style={styles.container}>
        {userType == 'viewer' ? 
          <ViewerView 
          updateScreen={updateScreen}/> : 
        userType == 'designer' ? 
          <DesignerView 
          updateScreen={updateScreen}/> :  
        <ChooseView 
          updateScreen={updateScreen}/>}
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
});
