import { NativeModules, Platform, Text, View } from 'react-native'
import React, { useEffect } from 'react'

const { MovrModuleRn } = NativeModules;

const MovrScreen = () => {
  useEffect(() => {
    MovrModuleRn.startFlutterActivity('', 0, (text) => {
      console.log(text);
    });
  }, [])
  return (
    <View>
      <Text>Hello from RN wrapper for Flutter {Platform.OS}!</Text>
    </View>
  )
}

export default MovrScreen;
