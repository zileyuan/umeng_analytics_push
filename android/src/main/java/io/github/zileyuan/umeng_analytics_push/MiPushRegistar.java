package io.github.zileyuan.umeng_analytics_push;

import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Build;
import android.text.TextUtils;
import com.taobao.accs.utl.ALog;
import com.taobao.accs.utl.UtilityImpl;
import com.taobao.agoo.BaseNotifyClickActivity;
import com.taobao.agoo.BaseNotifyClickActivity.INotifyListener;
import com.xiaomi.mipush.sdk.MiPushClient;
import com.xiaomi.mipush.sdk.MiPushMessage;

public class MiPushRegistar {
    private static String phoneBrand;

    public MiPushRegistar() {
    }

    public static boolean checkDevice(Context context) {
        boolean result = false;

        try {
            PackageManager manager = context.getPackageManager();
            PackageInfo pkgInfo = null;
            if (phoneBrand.equalsIgnoreCase("xiaomi") || phoneBrand.equalsIgnoreCase("redmi")) {
                pkgInfo = manager.getPackageInfo("com.xiaomi.xmsf", 4);
                if (pkgInfo != null && pkgInfo.versionCode >= 105) {
                    result = true;
                }
            }
        } catch (Throwable throwable) {
            ALog.e("MiPushRegistar", "checkDevice", throwable, new Object[0]);
        }

        ALog.d("MiPushRegistar", "checkDevice", new Object[]{"result", result});
        return result;
    }

    public static void register(Context context, String xiaomiId, String xiaomiKey) {
        try {
            if (!UtilityImpl.isMainProcess(context)) {
                ALog.e("MiPushRegistar", "register not in main process, return", new Object[0]);
                return;
            }

            if (checkDevice(context)) {
                ALog.i("MiPushRegistar", "register begin", new Object[0]);
                BaseNotifyClickActivity.addNotifyListener(new MiPushRegistar.XiaoMiNotifyListener());
                MiPushClient.registerPush(context, xiaomiId, xiaomiKey);
            }
        } catch (Throwable throwable) {
            ALog.e("MiPushRegistar", "register", throwable, new Object[0]);
        }

    }

    public static void unregister(Context context) {
        try {
            MiPushClient.unregisterPush(context);
        } catch (Throwable throwable) {
            ALog.e("MiPushRegistar", "unregister", throwable, new Object[0]);
        }

    }

    static {
        phoneBrand = Build.BRAND;
    }

    private static class XiaoMiNotifyListener implements INotifyListener {
        private XiaoMiNotifyListener() {
        }

        public String parseMsgFromIntent(Intent intent) {
            String msg = null;

            try {
                MiPushMessage miPushMessage = (MiPushMessage)intent.getSerializableExtra("key_message");
                msg = miPushMessage.getContent();
            } catch (Exception e) {
            }

            ALog.i("MiPushRegistar", "parseMsgFromIntent", new Object[]{"msg", msg});
            return msg;
        }

        public String getMsgSource() {
            return "xiaomi";
        }

        public String toString() {
            return "INotifyListener: " + this.getMsgSource();
        }
    }
}