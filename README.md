## Add firebase to project

Before running the below command install [firebase cli](https://firebase.google.com/docs/cli) and [flutterfire](https://firebase.google.com/docs/flutter/setup?platform=android).

- Dev
    ```cmd
    flutterfire configure --platforms=android --android-package-name=com.example.splittr.dev --android-out=android/app/src/dev/google-services.json --out=lib/core/firebase/firebase_options_dev.dart
    ```

- Prod
    ```cmd
    flutterfire configure --platforms=android --android-package-name=com.example.splittr --android-out=android/app/src/prod/google-services.json --out=lib/core/firebase/firebase_options_prod.dart
    ```

## Build Runner
```flutter
dart run build_runner build --delete-conflicting-outputs
```

## Configure flutter run for dev and prod

For Android Studio:
If DEV and PROD are not visible do the following:
1. Go to edit configuration.
2. Add name - DEV or PROD.
3. Add dart entry point as ```main_dev.dart``` for DEV and ```main_prod.dart``` for PROD.
4. In build flavor section - dev for DEV and prod for PROD.

For VS Code:
1. There is a launch.json file for it. 
2. You mfs can select the DEV or PROD there.

## Mason
1. Activate mason
   ```cmd
   dart pub global activate mason_cli
   ```
2. Go to mason folder
   ```cmd
   cd mason
   ```
3. Get mason bricks
   ```cmd
   mason get
   ```
   
## Create a page with mason
```cmd
mason make feature_page -o ../lib/features/ --on-conflict overwrite --feature_name [yourFeatureName]
```   

## Create a component with mason
```cmd
mason make feature_component -o ../lib/features/ --on-conflict overwrite --feature_name [yourFeatureName]
```

## Clean
```flutter
 flutter pub cache clean
```
```flutter
 flutter pub cache repair
```
```flutter
 flutter clean
```
