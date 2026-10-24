package com.retrogames.shadowcontract.shadow_contract

import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.lang.reflect.Method

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.retrogames.shadowcontract/unity_bridge"
    private var methodChannel: MethodChannel? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)

        methodChannel?.setMethodCallHandler { call, result ->
            when (call.method) {
                "sendToUnity" -> {
                    val gameObject = call.argument<String>("gameObject") ?: "FlutterBridgeReceiver"
                    val methodName = call.argument<String>("methodName") ?: "OnReceiveMessageFromFlutter"
                    val message = call.argument<String>("message") ?: ""

                    // Safely dispatch to UnityPlayer via reflection (or direct call if unityLibrary is linked)
                    val dispatched = dispatchToUnityPlayer(gameObject, methodName, message)
                    result.success(dispatched)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    /**
     * Called via JNI from Unity C# (UnityMessageDispatcher.SendToFlutter).
     */
    fun onUnityMessage(message: String) {
        runOnUiThread {
            methodChannel?.invokeMethod("onUnityMessage", message)
        }
    }

    private fun dispatchToUnityPlayer(gameObject: String, methodName: String, message: String): Boolean {
        return try {
            val unityPlayerClass = Class.forName("com.unity3d.player.UnityPlayer")
            val method: Method = unityPlayerClass.getMethod(
                "UnitySendMessage",
                String::class.java,
                String::class.java,
                String::class.java
            )
            method.invoke(null, gameObject, methodName, message)
            true
        } catch (e: ClassNotFoundException) {
            // Unity library not loaded in this session (e.g. running mock simulation mode)
            false
        } catch (e: Exception) {
            e.printStackTrace()
            false
        }
    }
}
