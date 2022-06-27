package com.imin.printer;

import android.app.Application;
import android.content.res.Configuration;
import android.util.Log;

import me.jessyan.autosize.AutoSize;
import me.jessyan.autosize.AutoSizeConfig;

public class PrinterApplication extends Application {
    private int orientation;

    @Override
    public void onCreate() {
        super.onCreate();
        initWindow();
    }

    private void initWindow() {
//        orientation = getResources().getConfiguration().orientation;
//        if (orientation == Configuration.ORIENTATION_LANDSCAPE) {
//            AutoSizeConfig.getInstance().setDesignWidthInDp(1280).setDesignHeightInDp(720);
//        } else {
//            AutoSizeConfig.getInstance().setDesignWidthInDp(720).setDesignHeightInDp(1280);
//        }
        Log.e("imin_printer"," Utils.getScreenWidth(this)==>"+Utils.getWidth(this)+",Utils.getScreenHeight(this)==>"+Utils.getHeight(this));
        AutoSizeConfig.getInstance()
                .setDesignWidthInDp(Utils.getWidth(this)/2)
                .setDesignHeightInDp(Utils.getHeight(this)<= 800?500:Utils.getHeight(this)/2);
        AutoSize.initCompatMultiProcess(this);
    }
}

