# React Native Movr SDK

## Getting started

`$ npm install movr_module_rn --save` or `$ yarn add movr_module_rn`

### Android

Add following repositories to your android/build.gradle file:

```javascript
allprojects {
  repositories {
      ...
      maven {
          url "$rootDir/../node_modules/movr_module_rn/modules/host/outputs/repo"
      }
      maven {
          url "https://storage.googleapis.com/download.flutter.io"
      }
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
import MovrModuleRn from 'movr_module_rn';
```
Config paramters
```javascript
const parameters = {
  apiKey: 'xxxxxx',
  userId: 'userId',
  apiBaseUrl: 'xxxxx',
  primaryColor: '#FF6666',
  fontFamily: 'Montserrat',
  startingPage: 'xxxxxx',
};
```
Convert JSON parameter to string and start MovrScreen with the string parameter

```javascript
MovrModuleRn.startFlutterActivity(JSON.stringify(parameters), text => {
  // 1st param - string paramter
  // 2nd param - callback which returns input argument
  console.log(text);
});
```

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

import MovrModuleRn from 'movr_module_rn';

const Colors = {
  white: '#fff',
  black: '#000',
  light: '#ddd',
  dark: '#333',
  lighter: '#eee',
  darker: '#111',
};

const App: React.FC = () => {
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
          onPress={() => {
            const parameters = {
              apiKey: 'xxxxxx',
              userId: 'userId',
              apiBaseUrl: 'xxxxx',
              primaryColor: '#FF6666',
              fontFamily: 'Montserrat',
              startingPage: 'xxxxxx',
            };
            MovrModuleRn.startFlutterActivity(
              JSON.stringify(parameters),
              text => {
                // 1st param - string argment
                // 2nd param - callback which returns input argument
                console.log(text);
              },
            );
          }}
        />
      </ScrollView>
    </SafeAreaView>
  );
};

export default App;
```
