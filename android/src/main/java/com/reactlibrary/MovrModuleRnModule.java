// MovrModuleRnModule.java

package com.reactlibrary;

import android.app.Activity;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugin.common.MethodChannel;
import org.json.JSONObject;
import org.json.JSONException;

public class MovrModuleRnModule extends ReactContextBaseJavaModule {
    private final String FLUTTER_ENGINE_ID = "flutter_engine";
    private final String CHANNEL = "com.movr.test_movr_module/result";

    private final ReactApplicationContext reactContext;

    public MovrModuleRnModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "MovrModuleRn";
    }

    @ReactMethod
    public void startFlutterActivity(String stringArgument, Callback callback) {
        Activity currentActivity = reactContext.getCurrentActivity();
        currentActivity.runOnUiThread(new Runnable() {
            public void run() {
                FlutterEngine flutterEngine = new FlutterEngine(currentActivity);
                flutterEngine.getDartExecutor().executeDartEntrypoint(
                    DartExecutor.DartEntrypoint.createDefault()
                );
                FlutterEngineCache.getInstance().put(FLUTTER_ENGINE_ID, flutterEngine);
                
                MethodChannel methodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL);
                methodChannel.setMethodCallHandler((call, result) -> {
                    String receiveResult = (String)call.arguments;
                    if (call.method.equals("receiveResult")) {
                    // println("Hello receiveResult! $receiveResult");
                    } else {
                        result.notImplemented();
                    }
                });
                methodChannel.invokeMethod("getResult", stringArgument);
                currentActivity.startActivity(FlutterActivity.withCachedEngine(FLUTTER_ENGINE_ID)
                    .build(currentActivity));
                callback.invoke("Received stringArgument: " + stringArgument);
            }
        });
        
    }
}
