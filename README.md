# BottomAniNavBar

Animated bottom navigation bar for Flutter

> Note: This is a modified version of "BottomNavigationBar" from Flutter team



## Getting Started

Add the dependency in `pubspec.yaml`:

```yaml
dependencies:
  bottom_ani_nav_bar: ^0.0.2
  ```

## Import it


```dart
import 'package:bottom_ani_nav_bar/bottom_ani_nav_bar.dart';
  ```

## Usage

```dart
// Imported as BottomAniNavBar
BottomAniNavBar(
    unselectedItemColor: Colors.red,
    currentIndex: _currentIndex,
    onTap: (int index) {
        setState(() {
            _currentIndex = index;
        });
    },
    items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(
                'Home',
                style: textStyle,
            )
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text(
                'Search',
                style: textStyle,
            )
        )
    ]);
```


[Home Page screenshot](https://raw.githubusercontent.com/omeasraf/BottomAniNavBar/master/ScreenShot.png)


## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.