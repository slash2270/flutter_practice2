package com.example.flutter_practice2

import android.R
import android.content.ContentValues.TAG
import android.content.Intent
import android.os.Bundle
import android.os.PersistableBundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import java.util.*
//import com.facebook.FacebookSdk
//import com.facebook.appevents.AppEventsLogger

class MainActivity: FlutterActivity() {

    /*var callbackManager = null

    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
        FacebookSdk.sdkInitialize(applicationContext)
        AppEventsLogger.activateApp(this)

        callbackManager = CallbackManager.Factory.create()

        LoginManager.getInstance().registerCallback(callbackManager,
            object : FacebookCallback<LoginResult?>() {
                fun onSuccess(loginResult: LoginResult) {
                    // App code
                    Log.d(TAG, "Check Result Token : " + loginResult.getAccessToken().getToken())
                    Log.d(
                        TAG,
                        "Check Result User Id  : " + loginResult.getAccessToken().getUserId()
                    )
                    Log.d(
                        TAG,
                        "Check Result Application Id : " + loginResult.getAccessToken()
                            .getApplicationId()
                    )
                    Log.d(
                        TAG,
                        "Check Result Permission : " + loginResult.getAccessToken().getPermissions()
                            .toString()
                    )
                    for (str in loginResult.getAccessToken().getPermissions()) {
                        Log.d(TAG, "Check Result Permission : $str")
                    }
                }

                fun onCancel() {
                    // App code
                }

                fun onError(exception: FacebookException?) {
                    // App code
                }
            })

        loginButton = findViewById<LoginButton>(R.id.login_button)
        loginButton.setReadPermissions(Arrays.asList("email", "public_profile"))
// If using in a fragment
// loginButton.setFragment(this);
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        callbackManager.onActivityResult(requestCode, resultCode, data)
        super.onActivityResult(requestCode, resultCode, data)
    }*/

}
