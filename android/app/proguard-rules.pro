## Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-keep class io.agora.** { *; }
-keep class com.google.firebase.** { *; }
-dontwarn io.flutter.embedding.**
-keep class com.dexterous.** { *; }

-ignorewarnings
-keep class * {
    public private *;
}