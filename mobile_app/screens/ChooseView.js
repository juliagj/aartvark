import { StatusBar } from 'expo-status-bar';
import React, { useState, useEffect } from 'react';
import { StyleSheet, Text, View} from 'react-native';
import { Button, Title, Colors } from 'react-native-paper';

export default function ChooseView(props) { 
    // based on what gets return, send to props and then to app and then to view
    function navigateToScreen(userType) {
        console.log(props);
        props.updateScreen(userType);
        console.log(userType);
    }

    return (
        <View style={styles.container}>
            <Title>How are you interacting with this exhibit?</Title>
           <Button 
            icon="emoticon-excited"
            color={Colors.grey800} 
            style={styles.button}
            mode="contained" 
            onPress={() => navigateToScreen('viewer')}> 
                Viewer
            </Button>
            <Button 
            icon="briefcase"
            color={Colors.grey800}  
            style={styles.button}
            mode="contained" 
            onPress={() => navigateToScreen('designer')}>
                Designer
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
    button: {
        width: 200,
        height: 50,
        justifyContent: 'center',
        margin: 8, 
        backgroundColor: 'darkgrey',
    }, 
  });
  