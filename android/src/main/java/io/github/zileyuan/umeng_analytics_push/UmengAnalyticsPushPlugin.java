package io.github.zileyuan.umeng_analytics_push;

import androidx.annotation.NonNull;

import android.content.Context;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import com.umeng.message.UTrack;
import com.umeng.message.tag.TagManager;
import com.umeng.message.common.inter.ITagManager;
import com.umeng.analytics.MobclickAgent;
import android.util.Log;

/** UmengAnalyticsPushPlugin */
public class UmengAnalyticsPushPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  public static MethodChannel methodChannel;
  public static EventChannel eventChannel;
  public static EventChannel.EventSink eventSink;
  private static Context context;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    context = flutterPluginBinding.getApplicationContext();
    methodChannel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "umeng_analytics_push");
    methodChannel.setMethodCallHandler(this);
    eventChannel = new EventChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "umeng_analytics_push/stream");
    eventChannel.setStreamHandler(
      new EventChannel.StreamHandler() {
        @Override
        public void onListen(Object args, final EventChannel.EventSink events) {
            Log.i("eventChannel", "adding listener");
            eventSink = events;
        }
        @Override
        public void onCancel(Object args) {
            Log.i("eventChannel", "cancelling listener");
            eventSink = null;
        }
      }
    );
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    methodChannel.setMethodCallHandler(null);
    eventChannel.setStreamHandler(null);
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  public static void registerWith(Registrar registrar) {
    context = registrar.context();
    methodChannel = new MethodChannel(registrar.messenger(), "umeng_analytics_push");
    methodChannel.setMethodCallHandler(new UmengAnalyticsPushPlugin());
    eventChannel = new EventChannel(registrar.messenger(), "umeng_analytics_push/stream");
    eventChannel.setStreamHandler(
      new EventChannel.StreamHandler() {
        @Override
        public void onListen(Object args, final EventChannel.EventSink events) {
            Log.i("eventChannel", "adding listener");
            eventSink = events;
        }
        @Override
        public void onCancel(Object args) {
            Log.i("eventChannel", "cancelling listener");
            eventSink = null;
        }
      }
    );
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("addTags")) {
      addTags(call, result);
    } else if (call.method.equals("deleteTags")) {
      deleteTags(call, result);
    } else if (call.method.equals("addAlias")) {
      addAlias(call, result);
    } else if (call.method.equals("setAlias")) {
      setAlias(call, result);
    } else if (call.method.equals("deleteAlias")) {
      deleteAlias(call, result);
    } else if (call.method.equals("pageStart")) {
      pageStart(call, result);
    } else if (call.method.equals("pageEnd")) {
      pageEnd(call, result);
    } else if (call.method.equals("event")) {
      event(call, result);
    } else {
      result.notImplemented();
    }
  }

  private void event(MethodCall call, Result result) {
    String eventId = call.argument("eventId");
    String label = call.argument("label");
    MobclickAgent.onEvent(context, eventId, label);
  }

  private void pageStart(MethodCall call, Result result) {
    String pageName = call.argument("pageName");
    MobclickAgent.onPageStart(pageName);
  }

  private void pageEnd(MethodCall call, Result result) {
    String pageName = call.argument("pageName");
    MobclickAgent.onPageEnd(pageName);
  }

  private void addTags(MethodCall call, Result result) {
    String tags = call.argument("tags");
    if (UmengAnalyticsPushFlutterAndroid.UmengPushAgent != null) {
      UmengAnalyticsPushFlutterAndroid.UmengPushAgent.getTagManager().addTags(new TagManager.TCallBack() {
        @Override
        public void onMessage(final boolean isSuccess, final ITagManager.Result result) {
          Log.i("umeng_push_tags", "addTags：--> " + String.valueOf(isSuccess));
        }
      }, tags);
    }
  }

  private void deleteTags(MethodCall call, Result result) {
    String tags = call.argument("tags");
    if (UmengAnalyticsPushFlutterAndroid.UmengPushAgent != null) {
      UmengAnalyticsPushFlutterAndroid.UmengPushAgent.getTagManager().deleteTags(new TagManager.TCallBack() {
        @Override
        public void onMessage(final boolean isSuccess, final ITagManager.Result result) {
          Log.i("umeng_push_tags", "deleteTags：--> " + String.valueOf(isSuccess));
        }
      }, tags);
    }
  }

  private void addAlias(MethodCall call, Result result) {
    String alias = call.argument("alias");
    String type = call.argument("type");
    if (UmengAnalyticsPushFlutterAndroid.UmengPushAgent != null) {
      UmengAnalyticsPushFlutterAndroid.UmengPushAgent.addAlias(alias, type, new UTrack.ICallBack() {
        @Override
        public void onMessage(boolean isSuccess, String message) {
          Log.i("umeng_push_alias", "addAlias：--> " + String.valueOf(isSuccess) + "; 消息：--> " + message);
        }
      });
    }
  }

  private void setAlias(MethodCall call, Result result) {
    String alias = call.argument("alias");
    String type = call.argument("type");
    if (UmengAnalyticsPushFlutterAndroid.UmengPushAgent != null) {
      UmengAnalyticsPushFlutterAndroid.UmengPushAgent.setAlias(alias, type, new UTrack.ICallBack() {
        @Override
        public void onMessage(boolean isSuccess, String message) {
          Log.i("umeng_push_alias", "setAlias：--> " + String.valueOf(isSuccess) + "; 消息：--> " + message);
        }
      });
    }
  }

  private void deleteAlias(MethodCall call, Result result) {
    String alias = call.argument("alias");
    String type = call.argument("type");
    if (UmengAnalyticsPushFlutterAndroid.UmengPushAgent != null) {
      UmengAnalyticsPushFlutterAndroid.UmengPushAgent.deleteAlias(alias, type, new UTrack.ICallBack() {
        @Override
        public void onMessage(boolean isSuccess, String message) {
          Log.i("umeng_push_alias", "deleteAlias：--> " + String.valueOf(isSuccess) + "; 消息：--> " + message);
        }
      });
    }
  }
}
