package com.example.flutternytimes;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

import android.os.Bundle;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "flutter-course.com/battery";

  private int getBatteryLevel() {
    int batterLevel = -1;
    if(VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
      BatteryManager batteryManager = (BatteryManager)getSystemService(BATTERY_SERVICE);
      batterLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
    } else {
      Intent intent = new ContextWrapper(getApplicationContext())
        .registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
      batterLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
    }
    return batterLevel;
  }

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    new MethodChannel(getFlutterView(), CHANNEL)
      .setMethodCallHandler(new MethodCallHandler() {
        @Override
        public void onMethodCall(MethodCall call, Result result) {
          if(call.method.equals("getBatteryLevel")) {
            int batterLevel = getBatteryLevel();
            if(batterLevel != -1) {
              result.success(batterLevel);
            } else {
              result.error("UNAVAILABLE", "Could not fetch battery level.", null);
            }
          } else {
            result.notImplemented();
          }
        }
      });
    GeneratedPluginRegistrant.registerWith(this);
  }
}
