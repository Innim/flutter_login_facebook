package ru.innim.flutter_login_facebook;

import androidx.annotation.NonNull;

import com.facebook.CallbackManager;
import com.facebook.login.LoginManager;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

/** FlutterLoginFacebookPlugin */
public class FlutterLoginFacebookPlugin implements FlutterPlugin, ActivityAware {
    private static final String _CHANNEL_NAME = "flutter_login_facebook";
    private static final String _METHOD_READY = "ready";

    private MethodChannel _dartChannel;

    private MethodCallHandler _methodCallHandler;
    private ActivityListener _activityListener;
    private CallbackManager _callbackManager;
    private ActivityPluginBinding _activityPluginBinding;
    private LoginCallback _loginCallback;

    @Override
    public void onAttachedToEngine(FlutterPluginBinding flutterPluginBinding) {
        final BinaryMessenger messenger = flutterPluginBinding.getBinaryMessenger();
        _dartChannel = new MethodChannel(messenger, _CHANNEL_NAME);
        _callbackManager = CallbackManager.Factory.create();
        _loginCallback = new LoginCallback();
        _activityListener = new ActivityListener(_callbackManager);
        _methodCallHandler = new MethodCallHandler(_loginCallback);
        _dartChannel.setMethodCallHandler(_methodCallHandler);
        _dartChannel.invokeMethod(_METHOD_READY, null);
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding activityPluginBinding) {
        _setActivity(activityPluginBinding);
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        _resetActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding activityPluginBinding) {
        _setActivity(activityPluginBinding);
    }

    @Override
    public void onDetachedFromActivity() {
        _resetActivity();
    }


    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        _methodCallHandler = null;
        _activityListener = null;
        _callbackManager = null;
        _activityPluginBinding = null;
        _loginCallback = null;
        _dartChannel.setMethodCallHandler(null);
    }

    private void _setActivity(ActivityPluginBinding activityPluginBinding) {
        _activityPluginBinding = activityPluginBinding;
        final LoginManager loginManager = LoginManager.getInstance();
        loginManager.registerCallback(_callbackManager, _loginCallback);
        activityPluginBinding.addActivityResultListener(_activityListener);
        _methodCallHandler.updateActivity(activityPluginBinding.getActivity());
    }

    private void _resetActivity() {
        if (_activityPluginBinding != null) {
            final LoginManager loginManager = LoginManager.getInstance();
            loginManager.unregisterCallback(_callbackManager);
            _activityPluginBinding.removeActivityResultListener(_activityListener);
            _activityPluginBinding = null;
            _methodCallHandler.updateActivity(null);
        }
    }
}
