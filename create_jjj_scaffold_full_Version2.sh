#!/usr/bin/env bash
set -e

# Script minimal para crear un scaffold Android y empaquetarlo en jjj-scaffold.zip
# Uso: chmod +x create_jjj_scaffold_full.sh && ./create_jjj_scaffold_full.sh
OUTDIR="SMS-JJJ-scaffold"
ZIPNAME="jjj-scaffold.zip"

rm -rf "$OUTDIR" "$ZIPNAME"
mkdir -p "$OUTDIR"

# Estructura básica
mkdir -p "$OUTDIR/app/src/main/java/com/smsforwardself"
mkdir -p "$OUTDIR/app/src/main/res/values"
mkdir -p "$OUTDIR/app/src/main/res/values-es"
mkdir -p "$OUTDIR/app/src/main/res/values-fr"
mkdir -p "$OUTDIR/app/src/main/res/values-ar"
mkdir -p "$OUTDIR/.github/workflows"

# settings.gradle
cat > "$OUTDIR/settings.gradle" <<EOF
rootProject.name = "SMSJjj"
include ':app'
EOF

# File: build.gradle (root)
cat > "$OUTDIR/build.gradle" <<EOF
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath "com.android.tools.build:gradle:7.4.2"
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:1.8.10"
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
EOF

# File: gradle.properties (basic)
cat > "$OUTDIR/gradle.properties" <<EOF
org.gradle.jvmargs=-Xmx1536m
android.useAndroidX=true
android.enableJetifier=true
EOF

# app module build.gradle
cat > "$OUTDIR/app/build.gradle" <<'EOF'
plugins {
    id 'com.android.application'
    id 'kotlin-android'
}

android {
    compileSdk 33

    defaultConfig {
        applicationId "com.smsforwardself"
        minSdk 21
        targetSdk 33
        versionCode 1
        versionName "0.1.0"
        testInstrumentationRunner "androidx.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        debug {
            // debug settings
        }
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_11
        targetCompatibility JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = '11'
    }
}

dependencies {
    implementation "org.jetbrains.kotlin:kotlin-stdlib:1.8.10"
    implementation 'androidx.core:core-ktx:1.9.0'
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'com.google.android.material:material:1.8.0'
}
EOF

# AndroidManifest.xml
cat > "$OUTDIR/app/src/main/AndroidManifest.xml" <<'EOF'
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.smsforwardself">

    <!-- Permisos requeridos -->
    <uses-permission android:name="android.permission.SEND_SMS" />
    <uses-permission android:name="android.permission.RECEIVE_SMS" />
    <uses-permission android:name="android.permission.READ_SMS" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />

    <application
        android:allowBackup="true"
        android:label="SMS-J.J.J."
        android:theme="@style/Theme.AppCompat.Light.NoActionBar">
        <activity android:name=".MainActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>

        <!-- Service para escuchar notificaciones -->
        <service
            android:name=".Service.NotificationListenerServiceImpl"
            android:label="Notifications Listener"
            android:permission="android.permission.BIND_NOTIFICATION_LISTENER_SERVICE">
            <intent-filter>
                <action android:name="android.service.notification.NotificationListenerService" />
            </intent-filter>
        </service>
    </application>
</manifest>
EOF

# MainActivity.kt
cat > "$OUTDIR/app/src/main/java/com/smsforwardself/MainActivity.kt" <<'EOF'
package com.smsforwardself

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Simple UI placeholder
        setContentView(android.R.layout.simple_list_item_1)
    }
}
EOF

# NotificationListenerService stub
mkdir -p "$OUTDIR/app/src/main/java/com/smsforwardself/Service"
cat > "$OUTDIR/app/src/main/java/com/smsforwardself/Service/NotificationListenerServiceImpl.kt" <<'EOF'
package com.smsforwardself.Service

import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification
import android.util.Log

class NotificationListenerServiceImpl : NotificationListenerService() {
    override fun onNotificationPosted(sbn: StatusBarNotification) {
        val pkg = sbn.packageName
        val notif = sbn.notification
        val ticker = notif.tickerText?.toString() ?: ""
        Log.i("SMSJJJ", "Notification from \$pkg: \$ticker")
        // Aquí implementarás la lógica de reglas, filtros y reenvío
    }

    override fun onNotificationRemoved(sbn: StatusBarNotification) {}
}
EOF

# strings.xml (default Spanish)
cat > "$OUTDIR/app/src/main/res/values/strings.xml" <<'EOF'
<resources>
    <string name="app_name">SMS-J.J.J.</string>
    <string name="welcome">Bienvenido a SMS-J.J.J.</string>
</resources>
EOF

# English
cat > "$OUTDIR/app/src/main/res/values-en/strings.xml" <<'EOF'
<resources>
    <string name="app_name">SMS-J.J.J.</string>
    <string name="welcome">Welcome to SMS-J.J.J.</string>
</resources>
EOF

# French
cat > "$OUTDIR/app/src/main/res/values-fr/strings.xml" <<'EOF'
<resources>
    <string name="app_name">SMS-J.J.J.</string>
    <string name="welcome">Bienvenue sur SMS-J.J.J.</string>
</resources>
EOF

# Arabic (right-to-left - simple translation)
cat > "$OUTDIR/app/src/main/res/values-ar/strings.xml" <<'EOF'
<resources>
    <string name="app_name">SMS-J.J.J.</string>
    <string name="welcome">مرحبًا بك في SMS-J.J.J.</string>
</resources>
EOF

# Simple README for the project (in repo)
cat > "$OUTDIR/README.md" <<'EOF'
SMS-J.J.J. scaffold
Paquete: com.smsforwardself
Descripción: Proyecto mínimo que captura notificaciones y sirve como base para reglas de reenvío.
Instrucciones: ver el script create_jjj_scaffold_full.sh en la raíz del ZIP.
EOF

# Privacy policy snippet
cat > "$OUTDIR/PRIVACY.md" <<EOF
Privacy: La aplicación procesa las notificaciones localmente en el dispositivo. No sube contenidos a servidores externos a menos que el usuario active webhooks.
Contacto: zambo0844@gmail.com
EOF

# Placeholder proguard
cat > "$OUTDIR/app/proguard-rules.pro" <<'EOF'
// Keep defaults
EOF

# Create a basic workflow file placeholder (the user will upload a copy into .github/workflows)
cat > "$OUTDIR/.github/workflows/build_apk.yml" <<'EOF'
name: Build APK

on:
  push:
    branches:
      - scaffold/jjj
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Set up JDK 11
        uses: actions/setup-java@v4
        with:
          distribution: 'temurin'
          java-version: '11'

      - name: Prepare Android SDK (install command-line tools)
        uses: reactivecircus/android-emulator-runner@v2
        with:
          api-level: 33
          target: default
          arch: x86_64
          force-avd-creation: false

      - name: Make gradlew executable
        run: chmod +x ./gradlew || true

      - name: Build Debug APK
        run: ./gradlew assembleDebug --stacktrace

      - name: Collect artifacts
        uses: actions/upload-artifact@v4
        with:
          name: smsjjj-artifacts
          path: |
            app/build/outputs/**/*.apk
            .
EOF

# Zip the scaffold
cd "$OUTDIR"
zip -r "../$ZIPNAME" ./*
cd ..

echo "Se ha creado $ZIPNAME con el scaffold minimal en $(pwd)/$ZIPNAME"
echo "Descomprime el ZIP para revisar los ficheros antes de subirlos al repo."