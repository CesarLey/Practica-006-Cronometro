# tiempoapp

Timer app built with Flutter.

Autor: Cesar (migrado desde repo compartido)

## Requisitos
- Flutter SDK (estable). Ejemplo probado con Flutter 3.35.5.
- Android SDK (para ejecutar en Android)

## Ejecutar localmente
1. Abrir terminal en la raíz del proyecto.
2. Instalar dependencias:

```powershell
flutter pub get
```

3. Ejecutar la app en un dispositivo/emulador conectado:

```powershell
flutter run
```

4. Para compilar un APK de release:

```powershell
flutter build apk --release
```

## Cambiar icono y splash
- Reemplaza `assets/icono_app.png` por tu logo (preferible PNG 1024x1024).
- Ejecuta:

```powershell
flutter pub get
flutter pub run flutter_launcher_icons:main
```

- Para el splash, coloca tu imagen como `android/app/src/main/res/mipmap-*/launch_image.png` y `ios/Runner/Assets.xcassets/LaunchImage.imageset/` según corresponda. El proyecto ya contiene configuraciones de ejemplo en `android/app/src/main/res/drawable/launch_background.xml`.

## Seguridad
- No comitees `local.properties`, keystores ni credenciales. Estos están incluidos en `.gitignore`.

## Licencia
Este proyecto es tuyo — súbelo a tu repositorio personal cuando estés listo.
