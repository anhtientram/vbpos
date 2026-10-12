# ML Kit Text Recognition - optional language packs (compileOnly, not bundled)
-dontwarn com.google.mlkit.vision.text.chinese.**
-dontwarn com.google.mlkit.vision.text.devanagari.**
-dontwarn com.google.mlkit.vision.text.japanese.**
-dontwarn com.google.mlkit.vision.text.korean.**
# Giữ ML Kit core (Latin)
-keep class com.google.mlkit.** { *; }
-keep class com.google.android.gms.** { *; }