package io.github.zileyuan.umeng_analytics_push;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** UmengAnalyticsPushPlugin */
public class UmengAnalyticsPushPlugin implements MethodCallHandler {
  private Registrar registrar;

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "umeng_analytics_push");
    channel.setMethodCallHandler(new UmengAnalyticsPushPlugin(registrar));
  }

  private UmengAnalyticsPushPlugin(Registrar registrar) {
    this.registrar = registrar;
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("init")) {
      boolean res = init(call, result);
      result.success(res);
    } else {
      result.notImplemented();
    }
  }

  private boolean init(MethodCall call, Result result) {
    return true;
  }
}
