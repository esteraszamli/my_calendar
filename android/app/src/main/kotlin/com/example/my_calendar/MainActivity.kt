package com.esteraszamlijonkisz.my_calendar

import io.flutter.embedding.android.FlutterActivity
import android.os.Build
import android.os.Bundle
import androidx.core.view.WindowCompat

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        // Enable edge-to-edge display
        WindowCompat.setDecorFitsSystemWindows(window, false)
        
        // For Android 15+ (API 35), edge-to-edge is enforced by default
        // The deprecated setDecorFitsSystemWindows still works but we should
        // ensure proper insets handling in Flutter
        
        super.onCreate(savedInstanceState)
    }
}
