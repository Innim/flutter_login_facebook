package ru.innim.flutter_facebook_wrapper;

import com.facebook.FacebookCallback;
import com.facebook.FacebookException;
import com.facebook.login.LoginResult;

import java.util.HashMap;

import io.flutter.plugin.common.MethodChannel;

public class LoginCallback implements FacebookCallback<LoginResult> {
    private MethodChannel.Result _pendingResult;

    public void addPending(MethodChannel.Result result) {
        if (_pendingResult != null)
            callError(ErrorCode.INTERRUPTED, "Waiting login result was been interrupted!");

        _pendingResult = result;
    }

    @Override
    public void onSuccess(LoginResult loginResult) {
        callResult(Results.loginSuccess(loginResult));
    }

    @Override
    public void onCancel() {
        callResult(Results.loginCancel());
    }

    @Override
    public void onError(FacebookException error) {
        callError(ErrorCode.LOGIN, error.getMessage());
    }

    private void callResult(HashMap<String, Object> data) {
        if (_pendingResult != null) {
            _pendingResult.success(data);
            _pendingResult = null;
        }
    }

    private void callError(int code, String message) {
        if (_pendingResult != null) {
            _pendingResult.error(Integer.toString(code), message, null);
            _pendingResult = null;
        }
    }
}
