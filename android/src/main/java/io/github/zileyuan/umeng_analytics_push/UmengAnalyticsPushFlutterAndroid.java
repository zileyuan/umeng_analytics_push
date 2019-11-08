package io.github.zileyuan.umeng_analytics_push;

import android.util.Log;
import android.content.Context;
import com.umeng.commonsdk.UMConfigure;
import com.umeng.message.IUmengRegisterCallback;
import com.umeng.analytics.MobclickAgent;
import com.umeng.message.PushAgent;


public class UmengAnalyticsFlutterAndroid {

    public static void androidInit(Context context, String appKey, String channel, boolean logEnable
        String messageSecret) {
        UMConfigure.setLogEnabled(logEnable);
        UMConfigure.init(context, appKey, channel, UMConfigure.DEVICE_TYPE_PHONE, messageSecret);
        if (!messageSecret.isEmpty()) {
            //获取消息推送代理示例
            PushAgent mPushAgent = PushAgent.getInstance(context);
            //注册推送服务，每次调用register方法都会回调该接口
            mPushAgent.register(new IUmengRegisterCallback() {
                @Override
                public void onSuccess(String deviceToken) {
                    //注册成功会返回deviceToken deviceToken是推送消息的唯一标志
                    Log.i("umeng_push", "注册成功：deviceToken：-------->  " + deviceToken);

                }
                @Override
                public void onFailure(String s, String s1) {
                    Log.e("umeng_push", "注册失败：-------->  " + "s:" + s + ",s1:" + s1);
                }
            });
            //后台进行日活统计及多维度推送的必调用方法，请务必调用
            mPushAgent.onAppStart();
        }
    }

    public static void androidOnResume(Context context) {
        MobclickAgent.onResume(context);
    }

    public static void androidOnPause(Context context) {
        MobclickAgent.onPause(context);
    }
}