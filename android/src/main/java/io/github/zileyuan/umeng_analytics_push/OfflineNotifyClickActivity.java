package io.github.zileyuan.umeng_analytics_push;

import com.umeng.message.UmengNotifyClickActivity;
import android.util.Log;
import java.util.List;
import android.os.Bundle;
import android.content.Intent;
import android.content.ComponentName;
import android.content.pm.ResolveInfo;

import org.android.agoo.common.AgooConstants;

public class OfflineNotifyClickActivity extends UmengNotifyClickActivity {

    private static String TAG = OfflineNotifyClickActivity.class.getName();
    private List<ResolveInfo> mApps;
    private ResolveInfo info;

    @Override
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
    }

    @Override
    public void onMessage(Intent intent) {
        super.onMessage(intent);  //此方法必须调用，否则无法统计打开数
        String body = intent.getStringExtra(AgooConstants.MESSAGE_BODY);
        Log.i(TAG, body);

        Intent mainIntent = new Intent(Intent.ACTION_MAIN, null);
        mainIntent.addCategory(Intent.CATEGORY_LAUNCHER);
        mainIntent.setPackage(this.getPackageName());
        mApps = getPackageManager().queryIntentActivities(mainIntent, 0);

        for (int i = 0; i < mApps.size(); i++) {
            info = mApps.get(i);
            String packageName = info.activityInfo.packageName;
            String activityName = info.activityInfo.name;

            ComponentName mComponentName = new ComponentName(packageName, activityName);
            Intent newIntent = new Intent();
            newIntent.setComponent(mComponentName);
            newIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            Bundle mExtras = new Bundle();
            mExtras.putString("message", body);
            newIntent.putExtras(mExtras);
            startActivity(newIntent);
            finish();
        }
    }
}