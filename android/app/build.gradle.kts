plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.ecommerce_products"
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
        applicationId = "com.example.ecommerce_products"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = "myappkey"
            keyPassword = "MyApp123!"
            storeFile = file("my-release-key.jks")
            storePassword = "MyApp123!"
        }
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false
            isShrinkResources = false
        }
        getByName("debug") {
            // Usa debug por defecto para evitar conflictos
            // signingConfig = signingConfigs.getByName("release")
        }
    }
}

dependencies {
    // Firebase BOM (Bill of Materials)
    implementation(platform("com.google.firebase:firebase-bom:32.7.0"))

    // Dependencias de Firebase
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-analytics")

    // Google Play Services Auth
    implementation("com.google.android.gms:play-services-auth:20.7.0")

    // Google Identity Services - ESSENTIAL para resolver el error
    implementation("com.google.android.gms:play-services-identity:18.0.1")

    // Dependencias adicionales de Auth API
    implementation("com.google.android.gms:play-services-base:18.2.0")
    implementation("com.google.android.gms:play-services-basement:18.2.0")

    // Facebook Login
    implementation("com.facebook.android:facebook-login:16.2.0")

    // Multidex para evitar el límite de métodos
    implementation("androidx.multidex:multidex:2.0.1")
//    implementation("com.google.android.gms:play-services-maps:18.2.0")
//    implementation("androidx.window:window:1.0.0")
//    implementation("androidx.window:window-java:1.0.0")
//    implementation(platform("com.google.firebase:firebase-bom:34.6.0"))
//
//    // Firebase
//    implementation("com.google.firebase:firebase-auth-ktx")
//    implementation("com.google.firebase:firebase-analytics-ktx")
//
//    // Google Sign-In
//    implementation("com.google.android.gms:play-services-auth:20.7.0")
}

flutter {
    source = "../.."
}
