## Add firebase to project

Before running the below command install [firebase cli](https://firebase.google.com/docs/cli) and [flutterfire](https://firebase.google.com/docs/flutter/setup?platform=android).

- Dev
    1. ```cmd
       flutterfire configure --platforms=android --android-package-name=com.example.splittr.dev --out=lib/core/firebase/firebase_options_dev.dart
       ```
    2. (IMP) Create a dev folder inside android/app/src/ and move the ```google-services.json``` file to dev folder.
    
- Prod
    1. ```cmd
       flutterfire configure --platforms=android --android-package-name=com.example.splittr --out=lib/core/firebase/firebase_options_prod.dart
       ```
    2. (IMP) Create a prod folder inside android/app/src/ and move the ```google-services.json``` file to prod folder.

## Build Runner
```flutter
dart run build_runner build --delete-conflicting-outputs
```

## Configure flutter run for dev and prod

For Android Studio:
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
