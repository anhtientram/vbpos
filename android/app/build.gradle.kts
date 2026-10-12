plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

import java.util.Properties
import java.io.FileInputStream

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.biexce.vbpos.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    buildFeatures {
        resValues = true
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.biexce.vbpos.app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        missingDimensionStrategy("default", "dev")

        ndk {
            abiFilters += listOf("arm64-v8a")
        }
    }

    flavorDimensions += "default"

    productFlavors {
        create("dev") {
            dimension = "default"
            resValue("string", "app_name", "VBPos Dev")
        }
        create("prod") {
            dimension = "default"
            resValue("string", "app_name", "VBPos")
        }
        create("local") {
            dimension = "default"
            resValue("string", "app_name", "VBPos Local")
        }
    }

    signingConfigs {
        create("release") {
            if (keystorePropertiesFile.exists()) {
                keyAlias = keystoreProperties["keyAlias"] as String
                keyPassword = keystoreProperties["keyPassword"] as String
                storeFile = file(keystoreProperties["storeFile"] as String)
                storePassword = keystoreProperties["storePassword"] as String
            }
        }
    }

    buildTypes {
        release {
            signingConfig = if (keystorePropertiesFile.exists()) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }

            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
            "proguard-rules.pro"
            )
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}

afterEvaluate {
    val versionSuffix = "-v${flutter.versionName}(${flutter.versionCode})"

    fun flutterApkDir() =
        layout.buildDirectory.dir("outputs/flutter-apk").get().asFile

    fun copyApkIfExists(sourceName: String, targetName: String) {
        val source = flutterApkDir().resolve(sourceName)
        val target = flutterApkDir().resolve(targetName)
        if (source.exists()) {
            source.copyTo(target, overwrite = true)
        }
    }

    fun registerVersionedApkCopy(flavorTaskName: String, flavor: String, buildType: String) {
        tasks.named(flavorTaskName).configure {
            doLast {
                val baseName = "app-$flavor-$buildType"
                copyApkIfExists(
                    sourceName = "$baseName.apk",
                    targetName = "$baseName$versionSuffix.apk",
                )
            }
        }
    }

    fun registerFlavorApkAlias(
        taskName: String,
        flavorTaskName: String,
        sourceApkName: String,
        targetApkName: String,
    ) {
        tasks.named(taskName).configure {
            dependsOn(flavorTaskName)
            doLast {
                copyApkIfExists(sourceApkName, targetApkName)
            }
        }
    }

    registerVersionedApkCopy("assembleDevDebug", "dev", "debug")
    registerVersionedApkCopy("assembleProdDebug", "prod", "debug")
    registerVersionedApkCopy("assembleDevRelease", "dev", "release")
    registerVersionedApkCopy("assembleProdRelease", "prod", "release")

    registerFlavorApkAlias(
        taskName = "assembleDebug",
        flavorTaskName = "assembleDevDebug",
        sourceApkName = "app-dev-debug.apk",
        targetApkName = "app-debug$versionSuffix.apk",
    )
    registerFlavorApkAlias(
        taskName = "assembleRelease",
        flavorTaskName = "assembleDevRelease",
        sourceApkName = "app-dev-release.apk",
        targetApkName = "app-release$versionSuffix.apk",
    )
}
