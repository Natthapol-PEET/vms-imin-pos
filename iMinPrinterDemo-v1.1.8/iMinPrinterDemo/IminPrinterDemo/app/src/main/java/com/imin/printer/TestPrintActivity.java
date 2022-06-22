package com.imin.printer;

import android.Manifest;
import android.annotation.TargetApi;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.content.res.Configuration;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.ColorMatrix;
import android.graphics.ColorMatrixColorFilter;
import android.graphics.Paint;
import android.os.Build;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Spinner;
import android.widget.SpinnerAdapter;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.imin.library.SystemPropManager;
import com.imin.printer.js.JsActivity;
import com.imin.printerlib.Callback;
import com.imin.printerlib.IminPrintUtils;
import com.imin.printerlib.print.PrintUtils;
import com.imin.printerlib.util.BytesUtil;
import com.imin.printerlib.util.LogUtils;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import android.os.Handler;
import android.os.Message;

import static com.imin.printerlib.print.PrintUtils.printSPISelfByte;
import static com.imin.printerlib.util.Utils.isDoubleQRDev;


public class TestPrintActivity extends AppCompatActivity {

    private RecyclerView rvView;
    private List<String> data;
    private EditText edit_bar_width, edit_bar_height, edit_bar_position, edit_qr_size, edit_qr_left, edit_qr_error_lev;
    private int barWidth, barHeight, barTextPos, qrCodeSize, qrCodeErrorLev, barAndQrLeftSize;
    private static final String TAG = "TestPrintActivity";
    private IminPrintUtils mIminPrintUtils;
    private int orientation;
    private GridLayoutManager settingLayoutManager;
    private BluetoothStateReceiver mBluetoothStateReceiver;
    private Spinner spin_one;
    private MyListView mLvPairedDevices;
    private int bluetoothPosition = -1;
    private DeviceListAdapter mAdapter;
    private int connectType;
    private Button jsPrintBtn;
    private List<String> connectTypeList;
    private int spinnerPosition;
    private TextView tv_tips;
    public static final int TOAST = 100;
    private EditText edit_tqr1_error_lev;
    private EditText edit_tqr1_left;
    private EditText edit_tqr2_error_lev;
    private EditText edit_tqr2_left;
    private EditText edit_tqr1_version;
    private EditText edit_tqr2_version;
    private EditText edit_tqr_size;
    private EditText edit_tqr_str1;
    private EditText edit_tqr_str2;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_test_print);
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.WRITE_EXTERNAL_STORAGE)
                != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this,
                    new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE,
                            Manifest.permission.READ_EXTERNAL_STORAGE, Manifest.permission.MOUNT_UNMOUNT_FILESYSTEMS}, 0);
        }
        edit_bar_width = findViewById(R.id.edit_bar_width);
        edit_bar_height = findViewById(R.id.edit_bar_height);
        edit_bar_position = findViewById(R.id.edit_bar_position);
        edit_qr_size = findViewById(R.id.edit_qr_size);
        edit_qr_left = findViewById(R.id.edit_qr_left);
        edit_qr_error_lev = findViewById(R.id.edit_qr_error_lev);
        jsPrintBtn = findViewById(R.id.js_print);
        tv_tips = findViewById(R.id.tv_tips);
        rvView = findViewById(R.id.rv_list);
        spin_one = findViewById(R.id.spin_one);
        edit_tqr_size = findViewById(R.id.edit_tqr_size);
        edit_tqr1_error_lev = findViewById(R.id.edit_tqr1_error_lev);
        edit_tqr1_left = findViewById(R.id.edit_tqr1_left);
        edit_tqr2_error_lev = findViewById(R.id.edit_tqr2_error_lev);
        edit_tqr2_left = findViewById(R.id.edit_tqr2_left);
        edit_tqr1_version = findViewById(R.id.edit_tqr1_version);
        edit_tqr2_version = findViewById(R.id.edit_tqr2_version);
        edit_tqr_str1 = findViewById(R.id.edit_tqr_str1);
        edit_tqr_str2 = findViewById(R.id.edit_tqr_str2);
        initView();
        initReceiver();
        if (mIminPrintUtils==null){
            mIminPrintUtils = IminPrintUtils.getInstance(TestPrintActivity.this);
        }

    }

    @Override
    protected void onResume() {
        super.onResume();
        fillAdapter();
    }

    @Override
    protected void onPause() {
        super.onPause();

    }

    @Override
    protected void onDestroy() {
        if (mBluetoothStateReceiver != null){
            unregisterReceiver(mBluetoothStateReceiver);
            mBluetoothStateReceiver = null;
        }

        mIminPrintUtils.release();
        super.onDestroy();
    }


    boolean isInit=false;
    private void initView() {

        String deviceModel = SystemPropManager.getModel();

        Log.i("xgh", "deviceModel:" + deviceModel);

        connectTypeList = new ArrayList<>();
        if (TextUtils.equals("M2-202", deviceModel) || TextUtils.equals("M2-203", deviceModel) || TextUtils.equals("M2-Pro", deviceModel)) {
            connectTypeList.add("SPI");
            connectTypeList.add("Bluetooth");
        } else if (TextUtils.equals("S1-701", deviceModel) || TextUtils.equals("S1-702", deviceModel)) {
            connectTypeList.add("USB");
            connectTypeList.add("Bluetooth");
        } else if (TextUtils.equals("D1p-601", deviceModel) || TextUtils.equals("D1p-602", deviceModel)
                || TextUtils.equals("D1p-603", deviceModel) || TextUtils.equals("D1p-604", deviceModel)
                || TextUtils.equals("D1w-701", deviceModel) || TextUtils.equals("D1w-702", deviceModel)
                || TextUtils.equals("D1w-703", deviceModel) || TextUtils.equals("D1w-704", deviceModel)
                || TextUtils.equals("D4-501", deviceModel) || TextUtils.equals("D4-502", deviceModel)
                || TextUtils.equals("D4-503", deviceModel) || TextUtils.equals("D4-504", deviceModel)
                || TextUtils.equals("D4-505", deviceModel) || TextUtils.equals("M2-Max", deviceModel)
                || TextUtils.equals("D1", deviceModel)|| TextUtils.equals("D1-Pro", deviceModel)) {
            connectTypeList.add("USB");
            connectTypeList.add("Bluetooth");
        } else {
            tv_tips.setVisibility(View.VISIBLE);
            rvView.setVisibility(View.GONE);
            tv_tips.setText("暂不支持当前设备");
        }

        ArrayAdapter<String> spinnerAdapter = new ArrayAdapter<>(this, android.R.layout.simple_spinner_item, connectTypeList);
        spinnerAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spin_one.setAdapter(spinnerAdapter);

        mLvPairedDevices = findViewById(R.id.lv_paired_devices);
        mAdapter = new DeviceListAdapter(this);
        mLvPairedDevices.setAdapter(mAdapter);
        mLvPairedDevices.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                bluetoothPosition = position;
                mAdapter.notifyDataSetChanged();
            }
        });
        jsPrintBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getApplication(), JsActivity.class);
                startActivity(intent);
            }
        });

        spin_one.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {

                if (R.id.spin_one == parent.getId()) {
                    spinnerPosition = position;

                    if (TextUtils.equals("USB", connectTypeList.get(position))) {
                        connectType = 1;
                        mLvPairedDevices.setVisibility(View.GONE);
                    } else if (TextUtils.equals("Bluetooth", connectTypeList.get(position))) {
                        connectType = 2;
                        if (BluetoothUtil.isBluetoothOn()) {
                            fillAdapter();
                        } else {
                            BluetoothUtil.openBluetooth(TestPrintActivity.this);
                        }
                    } else if (TextUtils.equals("SPI", connectTypeList.get(position))) {
                        connectType = 3;
                        if (mIminPrintUtils.isSPIPrint()) {
                            mLvPairedDevices.setVisibility(View.GONE);
                        } else {
                            Toast.makeText(TestPrintActivity.this, "当前设备不支持SPI", Toast.LENGTH_SHORT).show();
                        }
                    }

                }

            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });
        if (data == null) {
            data = new ArrayList<>();
            data.add("init printer");
            data.add("get printer status");
            data.add("feed paper");
            data.add("cut paper");
            data.add("print text");

            data.add("print a column of the table");
            data.add("print single image");
            data.add("print multiple images");

            data.add("print barcode");
            data.add("set barcode width");
            data.add("set barcode height");
            data.add("set barcode text position");

            data.add("print QR code");
            data.add("set QR code size");
            data.add("set QrCode error correction Lev");
            data.add("set barcode and QR coed left margin");
            data.add("start print service");
            data.add("print nv bitmap");
            data.add("print 128A");
            data.add("print 128B");
            data.add("print 128C");
            data.add("print Double QR");
        }


        orientation = getResources().getConfiguration().orientation;
        if (orientation == Configuration.ORIENTATION_LANDSCAPE) {
            settingLayoutManager = new GridLayoutManager(this, 6, GridLayoutManager.VERTICAL, false);
        } else {
            settingLayoutManager = new GridLayoutManager(this, 3, GridLayoutManager.VERTICAL, false);

        }
        rvView.setHasFixedSize(true);
        rvView.setNestedScrollingEnabled(false);
        rvView.setLayoutManager(settingLayoutManager);
        ButtonAdapter adapter = new ButtonAdapter(data, this);
        adapter.setOnClickListener(new OnClickListener() {
            @RequiresApi(api = Build.VERSION_CODES.M)
            @Override
            public void onClick(View view, int pos, Object o) {
                final int position=pos;
                Log.i("XGH", "position:222  " + position);

                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        try {
                                Log.i("XGH", "position:111   " + position);
                                switch (position) {
                                    case 0:
                                        isInit = true;
                                        Log.i("xgh", " :" + spinnerPosition + " :" + connectTypeList.get(spinnerPosition));
                                        if (TextUtils.equals("USB", connectTypeList.get(spinnerPosition))) {
                                            mIminPrintUtils.resetDevice();
                                            mIminPrintUtils.initPrinter(IminPrintUtils.PrintConnectType.USB);
                                        } else if (TextUtils.equals("Bluetooth", connectTypeList.get(spinnerPosition))) {
                                            Log.i("XGH", "bluetoothPosition:" + bluetoothPosition);
                                            if (bluetoothPosition >= 0) {
                                                BluetoothDevice device = mAdapter.getItem(bluetoothPosition);
                                                Log.i("XGH", "device:" + device);
                                                try {
                                                    mIminPrintUtils.resetDevice();
                                                    mIminPrintUtils.initPrinter(IminPrintUtils.PrintConnectType.BLUETOOTH, device);
                                                } catch (IOException e) {
                                                    e.printStackTrace();
                                                }
                                            }
                                        } else if (TextUtils.equals("SPI", connectTypeList.get(spinnerPosition))) {
                                            //mIminPrintUtils.resetDevice();
                                            mIminPrintUtils.initPrinter(IminPrintUtils.PrintConnectType.SPI);
                                        }

                                        break;
                                    case 1:
                                        runOnUiThread(new Runnable() {
                                            @Override
                                            public void run() {
                                                if (isInit == false){
                                                    Toast.makeText(TestPrintActivity.this, " -1" , Toast.LENGTH_SHORT).show();
                                                    return;
                                                }
                                                if (TextUtils.equals("USB", connectTypeList.get(spinnerPosition))) {
                                                    int status = mIminPrintUtils.getPrinterStatus(IminPrintUtils.PrintConnectType.USB);
                                                    //针对S1， //0：打印机正常 1：打印机未连接或未上电 3：打印头打开 7：纸尽  8：纸将尽  99：其它错误
                                                    Log.d("XGH", " print USB status:" + status);
                                                    Toast.makeText(TestPrintActivity.this, " " + status, Toast.LENGTH_SHORT).show();
                                                } else if (TextUtils.equals("Bluetooth", connectTypeList.get(spinnerPosition))) {
                                                    Toast.makeText(TestPrintActivity.this, "Not support", Toast.LENGTH_SHORT).show();
                                                } else if (TextUtils.equals("SPI", connectTypeList.get(spinnerPosition))) {
                                                    mIminPrintUtils.getPrinterStatus(IminPrintUtils.PrintConnectType.SPI, new Callback() {
                                                        @Override
                                                        public void callback(int status) {
                                                            Log.d("XGH", " print SPI status:" + status +"  PrintUtils.getPrintStatus==  "+ PrintUtils.getPrintStatus());
                                                           if (status == -1 && PrintUtils.getPrintStatus() == -1){
                                                               Toast.makeText(TestPrintActivity.this, " " + status, Toast.LENGTH_SHORT).show();
                                                           }else {
                                                               Toast.makeText(TestPrintActivity.this, String.valueOf(status), Toast.LENGTH_SHORT).show();
                                                           }

                                                        }

                                                    });
                                                }

                                            }
                                        });

                                        break;
                                    case 2:
                                        mIminPrintUtils.printAndLineFeed();
                                        mIminPrintUtils.printAndFeedPaper(50);

                                        break;
                                    case 3:
                                        mIminPrintUtils.partialCut();
                                        break;
                                    case 4:

//                                    mIminPrintUtils.printText("iMin致力于使用先进的技术来帮助合作伙伴实现业务数字化。" +
//                                            "我们致力于成为东盟国家领先的智能商务设备提供商，帮助合作伙伴有效地连接\n");

                                        mIminPrintUtils.printText("iMin committed to use advanced technologies to help our business partners digitize their business.We are dedicated in becoming a leading provider of smart business equipment " +
                                                "in ASEAN countries,assisting our partners to connect, create and utilize data effectively.\n");

//                                    mIminPrintUtils.setPageFormat(0);//80mm
//                                    mIminPrintUtils.printText("iMin committed to use advanced technologies to help our business partners digitize their business.We are dedicated in becoming a leading provider of smart business equipment " +
//                                            "in ASEAN countries,assisting our partners to connect, create and utilize data effectively.");
//                                    mIminPrintUtils.setPageFormat(1);//58mm
//                                    mIminPrintUtils.printText("iMin committed to use advanced technologies to help our business partners digitize their business.We are dedicated in becoming a leading provider of smart business equipment " +
//                                            "in ASEAN countries,assisting our partners to connect, create and utilize data effectively.");
//                                    mIminPrintUtils.setPageFormat(0);//80mm
//
//                                    mIminPrintUtils.setAlignment(1);
//                                    mIminPrintUtils.printText(text);
//                                    mIminPrintUtils.setAlignment(0);
//                                    mIminPrintUtils.setTextSize(16);
//                                    mIminPrintUtils.printText(text);
//                                    mIminPrintUtils.setTextSize(26);
//                                    mIminPrintUtils.setTextWidth(300);
//                                    mIminPrintUtils.printText(text);
//                                    mIminPrintUtils.setTextWidth(576);
//                                    mIminPrintUtils.setTextLineSpacing(1.5f);
//                                    mIminPrintUtils.printText(text);
//                                    mIminPrintUtils.setTextLineSpacing(1.0f);
//                                    mIminPrintUtils.setTextStyle(Typeface.BOLD_ITALIC);
//                                    mIminPrintUtils.printText(text);
//                                    mIminPrintUtils.setTextStyle(Typeface.NORMAL);
//                                    mIminPrintUtils.setTextTypeface(Typeface.MONOSPACE);
//                                    mIminPrintUtils.printText(text);
//                                    mIminPrintUtils.setTextTypeface(Typeface.DEFAULT);
//
//                                    mIminPrintUtils.printText("----------------------------------------------------------------");
//                                    mIminPrintUtils.printText("＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿");

                                        mIminPrintUtils.printAndFeedPaper(100);

                                        break;
                                    case 5:
                                        String[] strings3 = new String[]{"Test", "Description Description Description@48", "192.00"};
                                        int[] colsWidthArr3 = new int[]{2, 6, 2};
                                        int[] colsAlign3 = new int[]{0, 0, 2};
                                        int[] colsSize3 = new int[]{26, 26, 26};
                                        mIminPrintUtils.printColumnsText(strings3, colsWidthArr3,
                                                colsAlign3, colsSize3);

                                        //                        mIminPrintUtils.setPageFormat(0);//80mm
                                        //                        mIminPrintUtils.printColumnsText(strings3, colsWidthArr3,
                                        //                                colsAlign3, colsSize3);
                                        //                        mIminPrintUtils.setPageFormat(1);//58mm
                                        //                        mIminPrintUtils.printColumnsText(strings3, colsWidthArr3,
                                        //                                colsAlign3, colsSize3);
                                        //                        mIminPrintUtils.setPageFormat(0);//80mm

                                        mIminPrintUtils.printAndFeedPaper(100);
                                        /*byte[] bytes = new byte[2];
                                        bytes[0] = 0x1b;
                                        bytes[1] = 0x40;
                                       // mIminPrintUtils = IminPrintUtils.getInstance(TestPrintActivity.this);
                                        mIminPrintUtils.sendRAWData(bytes);*/

                                        break;
                                    case 6:

//                                    Bitmap bitmap_red = BitmapFactory.decodeResource(getResources(), R.drawable.icon);
//                                    bitmap_red = getBlackWhiteBitmap(bitmap_red);
//                                    bitmap_red = Bitmap.createScaledBitmap(bitmap_red, 400, 400, true);
//                                    mIminPrintUtils.printSingleBitmap(bitmap_red);

                                        Bitmap bitmap_black = BitmapFactory.decodeResource(getResources(), R.drawable.icon1);
                                        bitmap_black = getBlackWhiteBitmap(bitmap_black);
                                        mIminPrintUtils.printSingleBitmap(bitmap_black);

//                                    Bitmap bitmap = BitmapFactory.decodeResource(getResources(), R.drawable.ic_rabit);
//                                    mIminPrintUtils.printSingleBitmap(bitmap);
//                                    mIminPrintUtils.printSingleBitmap(bitmap, 1);
//                                    mIminPrintUtils.printSingleBitmap(bitmap, 2);
//                                    mIminPrintUtils.setPageFormat(0);//80mm
//                                    mIminPrintUtils.printSingleBitmap(bitmap);
//                                    mIminPrintUtils.setPageFormat(1);//58mm
//                                    mIminPrintUtils.printSingleBitmap(bitmap);
//                                    mIminPrintUtils.setPageFormat(0);//80mm

                                        mIminPrintUtils.printAndFeedPaper(100);

                                        break;
//
                                    case 7:
                                        List<Bitmap> mBitmapList1 = new ArrayList<>();
                                        Bitmap bitmap2 = BitmapFactory.decodeResource(getResources(), R.drawable.ic_rabit);
                                        mBitmapList1.add(bitmap2);
                                        mIminPrintUtils.printMultiBitmap(mBitmapList1, 1);
                                        mIminPrintUtils.printAndFeedPaper(100);
                                        break;
                                    case 8:
                                        try {
                                            mIminPrintUtils.setBarCodeHeight(80);
                                            mIminPrintUtils.setBarCodeWidth(2);
                                            mIminPrintUtils.printBarCode(4, "00999978", 1);
                                            mIminPrintUtils.printText("Test1\n");
                                            mIminPrintUtils.printBarCode(5, "123456789", 1);
                                            mIminPrintUtils.printText("Test2\n");
                                        } catch (UnsupportedEncodingException e) {
                                            e.printStackTrace();
                                        }
                                        mIminPrintUtils.printAndFeedPaper(100);
                                        break;
                                    case 9:
                                        //2-6
                                        if (Utils.isEmpty(edit_bar_width.getText().toString())) {
                                            barWidth = 4;
                                        } else {
                                            barWidth = Integer.valueOf(Utils.getNumberString(edit_bar_width.getText().toString()));
                                        }
                                        mIminPrintUtils.setBarCodeWidth(barWidth);
                                        break;
                                    case 10://0-255
                                        if (Utils.isEmpty(edit_bar_height.getText().toString())) {
                                            barHeight = 100;
                                        } else {
                                            barHeight = Integer.valueOf(Utils.getNumberString(edit_bar_height.getText().toString()));
                                        }
                                        mIminPrintUtils.setBarCodeHeight(barHeight);
                                        break;
                                    case 11:
                                        //0 none  1 up  2 down  3 up and down
                                        if (Utils.isEmpty(edit_bar_position.getText().toString())) {
                                            barTextPos = 1;
                                        } else {
                                            barTextPos = Integer.valueOf(Utils.getNumberString(edit_bar_position.getText().toString()));
                                        }
                                        mIminPrintUtils.setBarCodeContentPrintPos(barTextPos);
                                        break;
                                    case 12:
                                        //左
                                        mIminPrintUtils.printQrCode("123456", 0);
                                        //中
                                        mIminPrintUtils.printQrCode("123456", 1);
                                        //右
                                        mIminPrintUtils.printQrCode("123456", 2);
                                        mIminPrintUtils.printAndFeedPaper(100);
                                        break;
                                    case 13:
                                        //1-13
                                        if (Utils.isEmpty(edit_qr_size.getText().toString())) {
                                            qrCodeSize = 6;
                                        } else {
                                            qrCodeSize = Integer.valueOf(Utils.getNumberString(edit_qr_size.getText().toString()));
                                        }
                                        mIminPrintUtils.setQrCodeSize(qrCodeSize);

                                        break;
                                    case 14:
                                        //48-51
                                        if (Utils.isEmpty(edit_qr_error_lev.getText().toString())) {
                                            qrCodeErrorLev = 48;
                                        } else {
                                            qrCodeErrorLev = Integer.valueOf(Utils.getNumberString(edit_qr_error_lev.getText().toString()));
                                        }
                                        mIminPrintUtils.setQrCodeErrorCorrectionLev(qrCodeErrorLev);
                                        break;
                                    case 15:
                                        //0-576
                                        if (Utils.isEmpty(edit_qr_left.getText().toString())) {
                                            barAndQrLeftSize = 10;
                                        } else {
                                            barAndQrLeftSize = Integer.valueOf(Utils.getNumberString(edit_qr_left.getText().toString()));
                                        }
                                        mIminPrintUtils.setLeftMargin(barAndQrLeftSize);
                                        break;

                                    case 16:
                                        startService(new Intent(TestPrintActivity.this, TestService.class));
                                        break;
                                    case 17:
                                        startActivity(new Intent(TestPrintActivity.this, NvBitmapActivity.class));
                                        break;
                                    case 18:
                                        try {
                                            Log.i("XGH", "position=:  18 " );
                                            mIminPrintUtils.setBarCodeHeight(70);
                                            mIminPrintUtils.setBarCodeWidth(3);
                                            mIminPrintUtils.printBarCode(73, "{A1456AAA", 1);
                                            mIminPrintUtils.printText("QR128A\n");
                                            mIminPrintUtils.printAndLineFeed();
                                        } catch (UnsupportedEncodingException e) {
                                            e.printStackTrace();
                                        }
                                        break;
                                    case 19:
                                        try {
                                            Log.i("XGH", "position=:  19 " );
                                            mIminPrintUtils.setBarCodeHeight(70);
                                            mIminPrintUtils.setBarCodeWidth(3);
                                            mIminPrintUtils.printBarCode(73, "{B12CAa--", 1);
                                            mIminPrintUtils.printText("QR128B\n");
                                            mIminPrintUtils.printAndLineFeed();
                                        } catch (UnsupportedEncodingException e) {
                                            e.printStackTrace();
                                        }
                                        break;
                                    case 20:
                                        try {
                                            Log.i("XGH", "position=:  20 " );

                                            mIminPrintUtils.setBarCodeHeight(100);
                                            mIminPrintUtils.setBarCodeWidth(2);
                                            mIminPrintUtils.printBarCode(73, "{C009999789101", 1);
                                            mIminPrintUtils.printText("QR128C  {C009999789101 \n");
                                            mIminPrintUtils.printAndLineFeed();
                                        } catch (UnsupportedEncodingException e) {
                                            e.printStackTrace();
                                        }
                                        break;
                                    case 21:
                                        Log.i("XGH", "position=:  21 " );

                                        if (!isDoubleQRDev()){
                                            runOnUiThread(new Runnable() {
                                                @Override
                                                public void run() {
                                                    Toast.makeText(TestPrintActivity.this, "This model does not support", Toast.LENGTH_SHORT).show();

                                                }
                                            });
                                            return;
                                        }
                                        mIminPrintUtils.setDoubleQRSize(Integer.parseInt(edit_tqr_size.getText().toString().trim()));
                                        mIminPrintUtils.setDoubleQR1Level(Integer.parseInt(edit_tqr1_error_lev.getText().toString().trim()));
                                        mIminPrintUtils.setDoubleQR2Level(Integer.parseInt(edit_tqr2_error_lev.getText().toString().trim()));
                                        mIminPrintUtils.setDoubleQR1MarginLeft(Integer.parseInt(edit_tqr1_left.getText().toString().trim()));
                                        mIminPrintUtils.setDoubleQR2MarginLeft(Integer.parseInt(edit_tqr2_left.getText().toString().trim()));
                                        mIminPrintUtils.setDoubleQR1Version(Integer.parseInt(edit_tqr1_version.getText().toString().trim()));
                                        mIminPrintUtils.setDoubleQR2Version(Integer.parseInt(edit_tqr2_version.getText().toString().trim()));
                                        mIminPrintUtils.printDoubleQR(edit_tqr_str1.getText().toString().trim(), edit_tqr_str2.getText().toString().trim());
                                        mIminPrintUtils.printAndLineFeed();
                                        break;

                                }
                        }catch (Exception e){

                        }
                    }
                }).start();

            }



        });
        rvView.setAdapter(adapter);

    }

    private void getHexStr(String s){
        s = s.replace(" ","");
        String[] strings = s.split(",");
        byte[] bytes0=new byte[strings.length];

        for (int i=0;i<strings.length;i++){
            bytes0[i]= Byte.parseByte(strings[i]);
        }
        String ss =  BytesUtil.ByteArrToHex(bytes0);
        LogUtils.showLogCompletion(ss,1024);
    }
    private boolean checkNumber(String input) {
        for (char c : input.toCharArray()) {
            if (!Character.isDigit(c)) {
                return false;
            }
        }
        return true;
    }

    private Handler handler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            switch (msg.what) {
                case TOAST:
                    toast(msg.obj.toString());
                    break;
            }
        }
    };

    // 两次点击按钮接口之间的点击间隔不能少于1000毫秒
    private final int MIN_CLICK_DELAY_TIME = 1000;
    private long lastClickTime;

    public boolean isFastClick() {
        boolean flag = false;
        long curClickTime = System.currentTimeMillis();
        if ((curClickTime - lastClickTime) >= MIN_CLICK_DELAY_TIME) {
            flag = true;
        }
        lastClickTime = curClickTime;
        return flag;
    }


    private void initReceiver() {
        if (mBluetoothStateReceiver == null){
            mBluetoothStateReceiver = new BluetoothStateReceiver();
            IntentFilter filter = new IntentFilter();
            filter.addAction(BluetoothAdapter.ACTION_STATE_CHANGED);
            registerReceiver(mBluetoothStateReceiver, filter);
        }
    }


    class BluetoothStateReceiver extends BroadcastReceiver {

        @Override
        public void onReceive(Context context, Intent intent) {
            int state = intent.getIntExtra(BluetoothAdapter.EXTRA_STATE, -1);
            switch (state) {
                case BluetoothAdapter.STATE_TURNING_ON:
                    toast("Bluetooth ON");
                    break;

                case BluetoothAdapter.STATE_TURNING_OFF:
                    toast("Bluetooth OFF");
                    break;
            }
        }
    }

    protected void toast(String message) {
        Toast.makeText(TestPrintActivity.this, message, Toast.LENGTH_SHORT).show();
    }

    class DeviceListAdapter extends ArrayAdapter<BluetoothDevice> {

        public DeviceListAdapter(Context context) {
            super(context, 0);
        }

        @TargetApi(Build.VERSION_CODES.ECLAIR)
        @Override
        public View getView(int position, View convertView, ViewGroup parent) {

            BluetoothDevice device = getItem(position);
            if (convertView == null) {
                convertView = LayoutInflater.from(getContext()).inflate(R.layout.item_bluetooth_device, parent, false);
            }

            TextView tvDeviceName = (TextView) convertView.findViewById(R.id.tv_device_name);
            CheckBox cbDevice = (CheckBox) convertView.findViewById(R.id.cb_device);

            tvDeviceName.setText(device.getName());

            cbDevice.setChecked(position == bluetoothPosition);

            return convertView;
        }
    }


    private void fillAdapter() {
        List<BluetoothDevice> printerDevices = BluetoothUtil.getPairedDevices();
        mAdapter.clear();
        mAdapter.addAll(printerDevices);
        refreshButtonText(printerDevices);
    }

    private void refreshButtonText(List<BluetoothDevice> printerDevices) {
        if (printerDevices.size() > 0 && connectType == 2) {
            mLvPairedDevices.setVisibility(View.VISIBLE);
        }
    }


    public static Bitmap getBlackWhiteBitmap(Bitmap bitmap) {
        int w = bitmap.getWidth();
        int h = bitmap.getHeight();

        Bitmap resultBitmap = Bitmap.createBitmap(w, h, Bitmap.Config.RGB_565);
        int color = 0;
        int a, r, g, b, r1, g1, b1;
        int[] oldPx = new int[w * h];
        int[] newPx = new int[w * h];

        bitmap.getPixels(oldPx, 0, w, 0, 0, w, h);
        for (int i = 0; i < w * h; i++) {
            color = oldPx[i];
            r = Color.red(color);
            g = Color.green(color);
            b = Color.blue(color);
            a = Color.alpha(color);
            //黑白矩阵
            r1 = (int) (0.33 * r + 0.59 * g + 0.11 * b);
            g1 = (int) (0.33 * r + 0.59 * g + 0.11 * b);
            b1 = (int) (0.33 * r + 0.59 * g + 0.11 * b);
            //检查各像素值是否超出范围
            if (r1 > 255) {
                r1 = 255;
            }

            if (g1 > 255) {
                g1 = 255;
            }

            if (b1 > 255) {
                b1 = 255;
            }

            newPx[i] = Color.argb(a, r1, g1, b1);
        }
        resultBitmap.setPixels(newPx, 0, w, 0, 0, w, h);
        return getGreyBitmap(resultBitmap);
    }

    public static Bitmap getGreyBitmap(Bitmap bitmap) {
        if (bitmap == null) {
            return null;
        } else {
            int width = bitmap.getWidth();
            int height = bitmap.getHeight();
            int[] pixels = new int[width * height];
            bitmap.getPixels(pixels, 0, width, 0, 0, width, height);
            int[] gray = new int[height * width];

            int e;
            int i;
            int j;
            int g;
            for (e = 0; e < height; ++e) {
                for (i = 0; i < width; ++i) {
                    j = pixels[width * e + i];
                    g = (j & 16711680) >> 16;
                    gray[width * e + i] = g;
                }
            }

            for (i = 0; i < height; ++i) {
                for (j = 0; j < width; ++j) {
                    g = gray[width * i + j];
                    if (g >= 128) {
                        pixels[width * i + j] = -1;
                        e = g - 255;
                    } else {
                        pixels[width * i + j] = -16777216;
                        e = g - 0;
                    }

                    if (j < width - 1 && i < height - 1) {
                        gray[width * i + j + 1] += 3 * e / 8;
                        gray[width * (i + 1) + j] += 3 * e / 8;
                        gray[width * (i + 1) + j + 1] += e / 4;
                    } else if (j == width - 1 && i < height - 1) {
                        gray[width * (i + 1) + j] += 3 * e / 8;
                    } else if (j < width - 1 && i == height - 1) {
                        gray[width * i + j + 1] += e / 4;
                    }
                }
            }

            Bitmap mBitmap = Bitmap.createBitmap(width, height, Bitmap.Config.RGB_565);
            mBitmap.setPixels(pixels, 0, width, 0, 0, width, height);
            return mBitmap;
        }
    }

    private static Bitmap toGrayscale(Bitmap bmpOriginal) {
        int height = bmpOriginal.getHeight();
        int width = bmpOriginal.getWidth();
        Bitmap bmpGrayscale = Bitmap.createBitmap(width, height, Bitmap.Config.RGB_565);
        Canvas c = new Canvas(bmpGrayscale);
        Paint paint = new Paint();
        ColorMatrix cm = new ColorMatrix();
        cm.setSaturation(0F);
        ColorMatrixColorFilter f = new ColorMatrixColorFilter(cm);
        paint.setColorFilter(f);
        c.drawBitmap(bmpOriginal, 0.0F, 0.0F, paint);
        return bmpGrayscale;
    }


}
