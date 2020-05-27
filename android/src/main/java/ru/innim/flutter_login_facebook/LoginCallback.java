package ru.innim.flutter_login_facebook;

import com.facebook.FacebookCallback;
import com.facebook.FacebookException;
import com.facebook.Profile;
import com.facebook.ProfileTracker;
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
    public void onSuccess(final LoginResult loginResult) {
        final Profile profile = Profile.getCurrentProfile();
        if (profile == null) {
            new ProfileTracker() {
                @Override
                protected void onCurrentProfileChanged(Profile oldProfile, Profile currentProfile) {
                    stopTracking();
                    Profile.setCurrentProfile(currentProfile);
                    loginSuccess(loginResult);
                }
            };
        } else {
            loginSuccess(loginResult);
        }
    }

    @Override
    public void onCancel() {
        callResult(Results.loginCancel());
    }

    @Override
    public void onError(FacebookException error) {
        callResult(Results.loginError(error));
    }

    private void loginSuccess(final LoginResult loginResult) {
        callResult(Results.loginSuccess(loginResult));
    }

    private void callResult(HashMap<String, Object> data) {
        if (_pendingResult != null) {
            _pendingResult.success(data);
            _pendingResult = null;
        }
    }

    private void callError(String code, String message) {
        if (_pendingResult != null) {
            _pendingResult.error(code, message, null);
            _pendingResult = null;
        }
    }
}
