# Abjalandlord

A new Flutter project.

## Getting Started
### To build APK

```shell
flutter build apk --release --no-sound-null-safety --split-per-abi
```

### To run debug mode
```shell
flutter run --no-sound-null-safety 
```

#### To Build
```shell
flutter build appbundle
```

```
 flutter run --release --no-sound-null-safety  
```

### Updating the app’s version number
The default version number of the app is 1.0.0. To update it, navigate to the pubspec.yaml file and update the following line:
```shell
version: 1.0.0+1
```

xcrun simctl boot FF71AC1C-EDB9-4230-8DFA-C314B92D833A