package com.smk.dialogdemo.views;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.view.View;
import android.widget.Button;

import com.smk.dialogdemo.R;
import com.smk.dialogdemo.sevice.DialogService;

public class MainActivity extends FragmentActivity {
    private static final String TAG = "test";
    private SmartDialog smartDialog;

    private Button btn_click_me;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        findViewById(R.id.btn_click_me).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
//                showSmallDialog();
            }
        });
    }


    /**
     * 两个标题
     * 两个按键
     */
    private void showSmartDialog1() {
        if (null == smartDialog) {
            smartDialog = DialogFactory.createTwoTitleTwoButtonThemeDialog(this,
                    "确定删除?"
                    , "删除后，该设备所有信息将一并删除。"
                    , "確定", "取消"
                    , R.drawable.dialog_global_bg
                    , R.drawable.dialog_btn_positive_normal
                    , R.drawable.dialog_btn_negative_normal
                    , null
                    , null);
        }
        if (!smartDialog.isShowing()) {
            smartDialog.show();
        }
    }

    /**
     * 一个标题
     * 两个按键
     */
    private void showSmartDialog2() {
        if (null == smartDialog) {
            smartDialog = DialogFactory.createOneTitleTwoButtonThemeDialog(this
                    , "蓝牙功能已关闭，是否开启？"
                    , "确认"
                    , "取消"
                    , R.drawable.dialog_global_bg
                    , R.drawable.dialog_btn_positive_normal
                    , R.drawable.dialog_btn_negative_normal
                    , null
                    , null);
        }
        if (!smartDialog.isShowing()) {
            smartDialog.show();
        }
    }

    /**
     * 一个标题
     * 一个按键
     */
    private void showSmartDialog3() {
        if (null == smartDialog) {
            smartDialog = DialogFactory.createOneTitleOneButtonThemeDialog(this
                    , "正在连接..."
                    , "取消"
                    , R.drawable.dialog_global_bg
                    , R.drawable.dialog_btn_negative_normal
                    , null);
        }
        if (!smartDialog.isShowing()) {
            smartDialog.show();
        }
    }

    /**
     * 二个标题
     */
    private void showSmartDialog4() {
        if (null == smartDialog) {
            smartDialog = DialogFactory.createTwoTitleThemeDialog(this
                    , "同步失败！"
                    , "请\"设置\"，手动同步。"
                    , R.drawable.dialog_global_bg);
        }
        if (!smartDialog.isShowing()) {
            smartDialog.show();
        }
    }

    /**
     * 一个标题
     */
    private void showSmartDialog5() {
        if (null == smartDialog) {
            smartDialog = DialogFactory.createOneTitleThemeDialog(this, "正在连接...", R.drawable.dialog_global_bg);
        }
        if (!smartDialog.isShowing()) {
            smartDialog.show();
        }
    }


    private void showSmallDialog() {
        Intent it = new Intent();
        it.setAction(DialogService.ACTION_DIALOG_CONTROL);
        it.putExtra(DialogService.PARAM_CMD, 1);
        startService(it);
    }


}
