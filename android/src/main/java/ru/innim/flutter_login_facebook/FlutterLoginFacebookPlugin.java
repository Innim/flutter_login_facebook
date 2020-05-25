package ru.innim.flutter_login_facebook;

import com.facebook.CallbackManager;
import com.facebook.login.LoginManager;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterLoginFacebookPlugin */
public class FlutterLoginFacebookPlugin implements FlutterPlugin, ActivityAware {
    private static final String _CHANNEL_NAME = "flutter_login_facebook";

    private MethodChannel _dartChannel;

    private MethodCallHandler _methodCallHandler;
    private ActivityListener _activityListener;
    private CallbackManager _callbackManager;
    private ActivityPluginBinding _activityPluginBinding;
    private LoginCallback _loginCallback;

    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), _CHANNEL_NAME);
        final CallbackManager callbackManager = CallbackManager.Factory.create();
        final LoginManager loginManager = LoginManager.getInstance();
        final LoginCallback loginCallback = new LoginCallback();
        final MethodCallHandler handler = new MethodCallHandler(loginCallback);
        loginManager.registerCallback(callbackManager, loginCallback);
        registrar.addActivityResultListener(new ActivityListener(callbackManager));
        handler.updateActivity(registrar.activity());
        channel.setMethodCallHandler(handler);
    }

    @Override
    public void onAttachedToEngine(FlutterPluginBinding flutterPluginBinding) {
        final BinaryMessenger messenger = flutterPluginBinding.getBinaryMessenger();
        _dartChannel = new MethodChannel(messenger, _CHANNEL_NAME);
        _callbackManager = CallbackManager.Factory.create();
        _loginCallback = new LoginCallback();
        _activityListener = new ActivityListener(_callbackManager);
        _methodCallHandler = new MethodCallHandler(_loginCallback);
        _dartChannel.setMethodCallHandler(_methodCallHandler);
    }

    @Override
    public void onAttachedToActivity(ActivityPluginBinding activityPluginBinding) {
        _setActivity(activityPluginBinding);
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        _resetActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(ActivityPluginBinding activityPluginBinding) {
        _setActivity(activityPluginBinding);
    }

    @Override
    public void onDetachedFromActivity() {
        _resetActivity();
    }


    @Override
    public void onDetachedFromEngine(FlutterPluginBinding binding) {
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
