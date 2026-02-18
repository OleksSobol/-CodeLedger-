plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Auto-increment build number in pubspec.yaml on each build
tasks.register("incrementBuildNumber") {
    doLast {
        val pubspec = file("../../pubspec.yaml")
        val content = pubspec.readText()
        val regex = Regex("""(version:\s*\d+\.\d+\.\d+\+)(\d+)""")
        val match = regex.find(content)
        if (match != null) {
            val oldBuild = match.groupValues[2].toInt()
            val newBuild = oldBuild + 1
            val updated = content.replaceFirst(regex, "${match.groupValues[1]}$newBuild")
            pubspec.writeText(updated)
            println("Build number incremented: $oldBuild → $newBuild")
        }
    }
}

tasks.matching { it.name.startsWith("assemble") }.configureEach {
    dependsOn("incrementBuildNumber")
}

android {
    namespace = "com.osobol.code_ledger"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.osobol.code_ledger"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
