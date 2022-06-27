package com.imin.printer;

import android.app.AlertDialog;
import android.content.ContentUris;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.database.Cursor;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.provider.DocumentsContract;
import android.provider.MediaStore;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.imin.printerlib.IminPrintUtils;

import androidx.appcompat.app.AppCompatActivity;

public class NvBitmapActivity extends AppCompatActivity implements View.OnClickListener {
    private Button mAddBmpFilePath, mBmpLoad, mBmpPrint, mClearPath;
    private EditText mBmpPath_et;
    private static final int FILE_SELECT_CODE = 0;
    private IminPrintUtils mIminPrintUtils;
    private String loadPath;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_nv_bitmap);
        mAddBmpFilePath = findViewById(R.id.SelectBmpFile);
        mBmpLoad = findViewById(R.id.Load_nvbmp_btn);
        mBmpPrint = findViewById(R.id.Print_nvbmp_btn);
        mClearPath = findViewById(R.id.Clear_Path_Btn);
        mBmpPath_et = findViewById(R.id.Nvbmp_path_et);
        mAddBmpFilePath.setOnClickListener(this);
        mBmpLoad.setOnClickListener(this);
        mBmpPrint.setOnClickListener(this);
        mClearPath.setOnClickListener(this);
        mIminPrintUtils = IminPrintUtils.getInstance(NvBitmapActivity.this);

    }


    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.SelectBmpFile:
                selectBmpFile();
                Log.i("xgh", " selectBmpFile");
                break;
            case R.id.Load_nvbmp_btn:
                setDownloadNvBmp();
                break;
            case R.id.Print_nvbmp_btn:
                PrintNvBmp();

                break;
            case R.id.Clear_Path_Btn:
                mBmpPath_et.setText("");
                break;
        }
    }

    // 设置下载位图
    private void setDownloadNvBmp() {
        loadPath = mBmpPath_et.getText().toString().trim();
        if (mIminPrintUtils.setDownloadNvBmp(loadPath)) {
            Toast.makeText(NvBitmapActivity.this, getString(R.string.Download_bmp_prompt),
                    Toast.LENGTH_SHORT).show();
        }
    }


    // 打印位图【指定下载位图的索引】
    private void PrintNvBmp() {
        String[] printNumbers = null;
        printNumbers = new String[]{"printer bitmap 1",
                "printer bitmap 2",
                "printer bitmap 3"};
        AlertDialog.Builder b = new AlertDialog.Builder(this);
        b.setTitle(getString(R.string.Print_Bmp_btn));
        b.setSingleChoiceItems(printNumbers, -1,
                new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        switch (which) {
                            case 0:
                                mIminPrintUtils.printNvBitmap(1);
                                mIminPrintUtils.printAndFeedPaper(100);
                                dialog.dismiss();
                                break;
                            case 1:
                                mIminPrintUtils.printNvBitmap(2);
                                mIminPrintUtils.printAndFeedPaper(100);
                                dialog.dismiss();
                                break;
                            case 2:
                                mIminPrintUtils.printNvBitmap(3);
                                mIminPrintUtils.printAndFeedPaper(100);
                                dialog.dismiss();
                                break;
                            default:
                                break;
                        }
                    }
                });

        b.show();
    }

    // 选择bmp图片文件
    private void selectBmpFile() {
        showFileChooser();
        String bmpPath = mBmpPath_et.getText().toString().trim();
        Utils.putValue(NvBitmapActivity.this, "path", bmpPath);
    }

    // 显示文件选择路径
    private void showFileChooser() {
        Intent intent = new Intent(Intent.ACTION_GET_CONTENT);
        intent.setType("*/*");
        intent.addCategory(Intent.CATEGORY_OPENABLE);
        try {
            startActivityForResult(Intent.createChooser(intent, "Select a BIN file"), FILE_SELECT_CODE);
        } catch (android.content.ActivityNotFoundException ex) {
            Toast.makeText(this, "Please install a File Manager.",
                    Toast.LENGTH_SHORT).show();
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        switch (requestCode) {
            case FILE_SELECT_CODE:
                if (resultCode == RESULT_OK) {
                    // Get the Uri of the selected file
                    Uri uri = data.getData();
                    String path = Utils.getPath(NvBitmapActivity.this, uri);
                    String sharePath = Utils.getValue(NvBitmapActivity.this, "path", "").toString().trim();

                    if (!TextUtils.isEmpty(path)) {
                        if (TextUtils.isEmpty(path)) {
                            mBmpPath_et.setText(path + ";");
                        } else {
                            mBmpPath_et.setText(sharePath + path + ";");
                        }
                    }
                }
                break;
        }
        super.onActivityResult(requestCode, resultCode, data);
    }

}
