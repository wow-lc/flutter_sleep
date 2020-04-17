package com.example.flutter_sleep;

import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Bundle;
import android.text.TextUtils;

import androidx.annotation.NonNull;

import com.tencent.bugly.crashreport.CrashReport;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "sleep.flutter.io/battery";
  private MethodChannel methodChannel;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    Context context = getApplicationContext();
    // 获取当前包名
    String packageName = context.getPackageName();
    // 获取当前进程名
    String processName = getProcessName(android.os.Process.myPid());
    // 设置是否为上报进程
    CrashReport.UserStrategy strategy = new CrashReport.UserStrategy(context);
    strategy.setUploadProcess(processName == null || processName.equals(packageName));
    // 初始化Bugly
    CrashReport.initCrashReport(getApplicationContext(), "4c086a4171", true);
  }

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);
    methodChannel = new MethodChannel(flutterEngine.getDartExecutor(), CHANNEL);
    methodChannel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        if (call.method.equals("getBatteryLevel")) {
          int batteryLevel = getBatteryLevel();
          if (batteryLevel != -1) {
            result.success(batteryLevel);
          } else {
            result.error("UNAVAILABLE", "Battery level not available.", null);
          }
        } else {
          result.notImplemented();
        }
      }
    });
  }

  private int getBatteryLevel() {
    int batteryLevel = -1;
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
      BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
      batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
    } else {
      Intent intent = new ContextWrapper(getApplicationContext()).registerReceiver(null,
          new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
      batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100)
          / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
    }

    return batteryLevel;
  }

  /**
   * 获取进程号对应的进程名
   * 
   * @param pid 进程号
   * @return 进程名
   */
  private static String getProcessName(int pid) {
    BufferedReader reader = null;
    try {
      reader = new BufferedReader(new FileReader("/proc/" + pid + "/cmdline"));
      String processName = reader.readLine();
      if (!TextUtils.isEmpty(processName)) {
        processName = processName.trim();
      }
      return processName;
    } catch (Throwable throwable) {
      throwable.printStackTrace();
    } finally {
      try {
        if (reader != null) {
          reader.close();
        }
      } catch (IOException exception) {
        exception.printStackTrace();
      }
    }
    return null;
  }
}
