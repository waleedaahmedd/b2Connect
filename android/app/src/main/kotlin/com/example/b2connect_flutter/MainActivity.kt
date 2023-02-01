package com.bsquaredwifi.app

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.os.Handler
import android.text.TextUtils
import android.widget.Toast
import com.payby.android.iap.view.*
import com.payby.android.iap.view.OnPayResultListener
import com.payby.android.iap.view.PayTask


class MainActivity : FlutterActivity(), OnPayResultListener {

    private val CHANNEL = "PayBy.Method.Channel"
    private lateinit var pbManager: PbManager
    var mIapDeviceId: String? = ""
    private var mToken: String? = ""
    private var mPartnerId: String? = ""
    private var sign: String? = ""
    private var mAppId: String? = ""
    private var payResult = ""
    private var methodChannel: MethodChannel? = null


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        pbManager = PbManager.getInstance(this)

        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        methodChannel?.setMethodCallHandler { call, result ->
            if (call.method == "getDeviceId") {
                val deviceId = getDeviceId()
                result.success(deviceId)

                /* if (batteryLevel != -1) {
                     result.success(batteryLevel)
                 } else {
                     result.error("UNAVAILABLE", "Battery level not available.", null)
                 }*/
            } else if (call.method == "startPay") {

                this.mToken = call.argument("mToken")
                this.mIapDeviceId = call.argument("mIapDeviceId")
                this.mPartnerId = call.argument("mPartnerId")
                this.sign = call.argument("sign")
                this.mAppId = call.argument("mAppId")
                pbManager.onPayResultListener = this
                result.success("Success")
                startPay()
            } else {
                result.notImplemented()
            }
        }
    }


    private fun getDeviceId(): String? {
        mIapDeviceId = pbManager.iapDeviceID
        return mIapDeviceId
    }

/*
20220331000000291 PRO
    "20220203000000261 "
*/
    private fun startPay() {
    val task = PayTask.with(this.mToken, this.mIapDeviceId, this.mPartnerId, this.sign, "20220331000000291")
    pbManager.pay(task, Environment.PRO)
        pbManager.payWithOrderCallback(MainActivity())
        /*return startPayResult*/
    }

    override fun onGetPayState(state: String) {

        runOnUiThread {
            methodChannel?.invokeMethod("onCallFinish",state)
        }
        // print(payResult)

        /*  when (state) {
              "SUCCESS" -> payResult = "Paid"
              else -> Toast.makeText(applicationContext, "Something went wrong during pay-by payment. State: $state", Toast.LENGTH_SHORT).show()
          }*/
        /*if (TextUtils.equals(result, "SUCCESS")) {
            Toast.makeText(applicationContext, "this is toast message", Toast.LENGTH_SHORT).show()
        } else if (TextUtils.equals(result, "PAID")) {
            Toast.makeText(applicationContext, "this is toast message", Toast.LENGTH_SHORT).show()
        } else if (TextUtils.equals(result, "PAYING")) {
            Toast.makeText(applicationContext, "this is toast message", Toast.LENGTH_SHORT).show()
        } else if (TextUtils.equals(result, "FAIL")) {
            Toast.makeText(applicationContext, "this is toast message", Toast.LENGTH_SHORT).show()
        } else {
            Toast.makeText(applicationContext, "this is toast message", Toast.LENGTH_SHORT).show()
        }*/
    }

    override fun onGetProtocolState(protocolState: String) {
        //PROTOCOL-SUCCESS,PROTOCOL-FAIL
        if (TextUtils.equals(protocolState, "PROTOCOL-SUCCESS")) {
            Toast.makeText(applicationContext, "this is toast message", Toast.LENGTH_SHORT).show()
        } else if (TextUtils.equals(protocolState, "PROTOCOL-FAIL")) {
            Toast.makeText(applicationContext, "this is toast message", Toast.LENGTH_SHORT).show()
        }
    }

    override fun onOrder(onOrderSuccessCallback: OnOrderSuccessCallback?, onOrderFailCallback: OnOrderFailCallback?) {
        print(onOrderSuccessCallback)
        // val task = PayTask.with(this.mToken, this.mIapDeviceId, this.mPartnerId, this.sign, this.mAppId)
        // pbManager.pay(task, Environment.PRO)
        /* Handler().postDelayed(Runnable {
             onOrderSuccessCallback!!.onSuccess(task, Environment.PRO)
             Toast.makeText(MainActivity(), "on order done", Toast.LENGTH_SHORT).show()
         }, 3000)
         Handler().postDelayed({
             onOrderFailCallback!!.onFail()
             Toast.makeText(MainActivity(), "It looks like something went wrong! Please try again later.", Toast.LENGTH_SHORT).show()
         }, 4000)*/

        /* if (!TextUtils.isEmpty(mToken)) {
             val signString = "iapAppId=$mAppId&iapDeviceId=$mIapDeviceId&iapPartnerId=$mPartnerId&token=$mToken"
             val sign: String = Base64.encode(
                     RsaUtils.sign(
                             signString, StandardCharsets.UTF_8, RsaUtils.getPrivateKey(keyDev)))
             val task = PayTask.with(mToken, mIapDeviceId, mPartnerId, sign, mAppId)
             Handler().postDelayed({ onOrderSuccessCallback!!.onSuccess(task, Environment.DEV) }, 3000)
         } else {
             Handler().postDelayed({ onOrderFailCallback!!.onFail() }, 4000)
         }*/
    }


}