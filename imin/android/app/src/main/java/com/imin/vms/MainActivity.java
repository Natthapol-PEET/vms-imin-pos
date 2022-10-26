package com.imin.vms;

// Flutter Plugin
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;
import android.bluetooth.BluetoothDevice;

import android.widget.ArrayAdapter;
import android.content.Context;
import android.view.View;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "samples.flutter.dev/battery";
    private int bluetoothPosition = 0;
    // private DeviceListAdapter mAdapter;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            // Note: this method is invoked on the main thread.
                            if (call.method.equals("getBatteryLevel")) {
                                int batteryLevel = getBatteryLevel();

                                if (batteryLevel != -1) {
                                    result.success(batteryLevel);
                                } else {
                                    result.error("UNAVAILABLE", "Battery level not available.", null);
                                }
                            }

                            if (call.method.equals("setInitPrinter")) {
                                int initPrinter = setInitPrinter();
                                // Log.i("xgh", "deviceModel:2" );
                                result.success(initPrinter);
                                // if (initPrinter != -1) {
                                //     result.success(initPrinter);
                                // } else {
                                //     result.error("UNAVAILABLE", "Battery level not available.", null);
                                // }
                            } else {
                                result.notImplemented();
                            }
                        });
    }

    private int getBatteryLevel() {
        int batteryLevel = -1;
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
        } else {
            Intent intent = new ContextWrapper(getApplicationContext()).registerReceiver(null,
                    new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
            batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
                    intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
        }

        return batteryLevel;
    }

    private int setInitPrinter() {
        // BluetoothDevice device = mAdapter.getItem(bluetoothPosition);
        // startActivity(new Intent(this,TestPrintActivity.class));
        // Log.i("xgh", "deviceModel:" + device);
        return 5;
    }
}

// class DeviceListAdapter extends ArrayAdapter<BluetoothDevice> {

//     public DeviceListAdapter(Context context) {
//         super(context, 0);
//     }

//     @TargetApi(Build.VERSION_CODES.ECLAIR)
//     @Override
//     public View getView(int position, View convertView, ViewGroup parent) {

//         BluetoothDevice device = getItem(position);
//         if (convertView == null) {
//             convertView = LayoutInflater.from(getContext()).inflate(R.layout.item_bluetooth_device, parent, false);
//         }

//         TextView tvDeviceName = (TextView) convertView.findViewById(R.id.tv_device_name);
//         CheckBox cbDevice = (CheckBox) convertView.findViewById(R.id.cb_device);

//         tvDeviceName.setText(device.getName());

//         cbDevice.setChecked(position == bluetoothPosition);

//         return convertView;
//     }
// }
