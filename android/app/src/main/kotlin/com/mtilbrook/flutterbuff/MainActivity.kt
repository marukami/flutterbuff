package com.mtilbrook.flutterbuff

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.os.Bundle
import com.google.firebase.auth.FirebaseAuth
import com.mtilbrook.flutterbuff.AuthActivity.Companion.RES_KEY_USER

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

  private val appMethodChannel by lazy {
    MethodChannel(flutterView, "com.mtilbrook.app")
  }

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    appMethodChannel
        .setMethodCallHandler { call: MethodCall, callResult: MethodChannel.Result ->
          when (call.method) {
            "authorize" -> {
              val intent = Intent(this@MainActivity, AuthActivity::class.java)
              startActivityForResult(intent, AuthActivity.REQ_CODE)
              callResult.success(true)
            }
            "currentUser" -> {
              val user = FirebaseAuth
                  .getInstance()
                  .currentUser
                  ?.let(::firebaseUserToProtoUser)
              appMethodChannel.invokeMethod("authResult", user?.toByteArray())
            }
          }
        }
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
    super.onActivityResult(requestCode, resultCode, data)
    if (requestCode == AuthActivity.REQ_CODE) {
      val user = data
          ?.takeIf { resultCode == Activity.RESULT_OK }
          ?.getByteArrayExtra(RES_KEY_USER)
      appMethodChannel.invokeMethod("authResult", user)


    }
  }
}
