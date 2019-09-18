# Deploy
See https://flutter.dev/docs/deployment/android
- Generates an UPLOAD key (different from a signing key now google managed those)
1. `keytool -genkey -v -keystore C:\Users\olly\projects\ctw_flutter/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key`
2. `flutter build appbundle`

`<app dir>/android/key.properties` looks like:
```
storePassword=...
keyPassword=...
keyAlias=key
storeFile=C:/Users/olly/projects/ctw_flutter/key.jks
```

# Icon:
`flutter pub run flutter_launcher_icons:main`