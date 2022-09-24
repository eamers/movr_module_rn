# React Native Movr SDK

## Getting started

`$ npm install movr_module_rn --save` or `$ yarn add movr_module_rn`

### Android

Add following repositories to your android/build.gradle file:

```javascript
repositories {
    maven {
        url "$rootDir/../node_modules/movr_module_rn/modules/host/outputs/repo"
    }
    maven {
        url "https://storage.googleapis.com/download.flutter.io"
    }
}
```

### iOS

- Add following to your Podfile:

```javascript
require_relative '../node_modules/movr_module_rn/ios/pods'

…
target ‘YourProjectName’ do
 …
 use_movr_module_rn!()
 …
end

```
- Run cd ios && pod install

## Usage
```javascript
import {MovrScreen} from 'movr_module_rn';
```
Implement code to navigate to MovrScreen

## Example
```javascript
import React from 'react';
import {
  Button,
  SafeAreaView,
  ScrollView,
  StatusBar,
  useColorScheme,
} from 'react-native';
import {NavigationContainer, ParamListBase} from '@react-navigation/native';
import {
  createNativeStackNavigator,
  NativeStackScreenProps,
} from '@react-navigation/native-stack';
import {MovrScreen} from 'movr_module_rn';

// import { Colors, Header } from 'react-native/Libraries/NewAppScreen';
const Colors = {
  white: '#fff',
  black: '#000',
  light: '#ddd',
  dark: '#333',
  lighter: '#eee',
  darker: '#111',
};

const Stack = createNativeStackNavigator();

function HomeScreen({navigation}: NativeStackScreenProps<ParamListBase>) {
  const isDarkMode = useColorScheme() === 'dark';

  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
    flex: 1,
  };
  return (
    <SafeAreaView style={backgroundStyle}>
      <StatusBar barStyle={isDarkMode ? 'light-content' : 'dark-content'} />
      <ScrollView
        contentInsetAdjustmentBehavior="automatic"
        style={backgroundStyle}>
        <Button
          title={'Start Movr Screen'}
          onPress={() => navigation.navigate('MovrScreen')}
        />
      </ScrollView>
    </SafeAreaView>
  );
}

const App: React.FC = () => {
  return (
    <NavigationContainer>
      <Stack.Navigator>
        <Stack.Screen name="Home" component={HomeScreen} />
        <Stack.Screen name="MovrScreen" component={MovrScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
};

export default App;
```
