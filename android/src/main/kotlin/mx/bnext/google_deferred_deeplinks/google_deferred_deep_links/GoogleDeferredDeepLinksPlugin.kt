package mx.bnext.google_deferred_deeplinks.google_deferred_deep_links

import android.content.Context
import android.content.SharedPreferences
import android.text.TextUtils
import androidx.annotation.NonNull
import android.util.Log

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** GoogleDeferredDeepLinksPlugin */
class GoogleDeferredDeepLinksPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context
  private var listener: SharedPreferences.OnSharedPreferenceChangeListener? = null
  private val deferredDeepLinkUpdate = "onDeferredDeepLink"

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "google_deferred_deep_links")
    context = flutterPluginBinding.applicationContext
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "onStart"){

      Log.d("GoogleDeferredDeepLinksPlugin", "SI PUDE ENTRAAAAAAAAR al metodo onStart")

      val sp = context.getSharedPreferences(
              "google.analytics.deferred.deeplink.prefs",
              Context.MODE_PRIVATE
      )
      val isEmpty = deepLinkChecker(sp)
      if (isEmpty) {
        if (listener != null) {
          sp.unregisterOnSharedPreferenceChangeListener(listener);
        }
        listener =
                SharedPreferences.OnSharedPreferenceChangeListener { prefs: SharedPreferences, key: String ->
                  if (key == "deeplink") {
                    deepLinkChecker(prefs)
                  }
                }
        sp.registerOnSharedPreferenceChangeListener(listener);
      }
      result.success("Success")
    }else{
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    Log.d("GoogleDeferredDeepLinksPlugin", "Metodo onDetachedFromEngine Se inicio correctamente")
    Log.d("GoogleDeferredDeepLinksPlugin", "Estado de listener : $listener")

    if ( listener != null ){
      val sp = binding.applicationContext.getSharedPreferences(
              "google.analytics.deferred.deeplink.prefs",
              Context.MODE_PRIVATE
      )
      sp.unregisterOnSharedPreferenceChangeListener(listener)
      listener = null
    }
    channel.setMethodCallHandler(null)
  }

  private fun deepLinkChecker(@NonNull sp: SharedPreferences): Boolean{
    Log.d("GoogleDeferredDeepLinksPlugin", "Metodo deepLinkChecker Se inicio correctamente")

    val markSP =
            context.getSharedPreferences("google_ads_deferred_deep_link.mark", Context.MODE_PRIVATE)
    val deepLink: String? = sp.getString("deeplink", null)
    val isEmpty = TextUtils.isEmpty(deepLink)
    if (!isEmpty) {
      val cTime = sp.getLong("timestamp", 0L)
      val markTime = markSP.getLong("timestamp", -1L)
      if (markTime != cTime) {
        markSP.edit().putLong("timestamp", cTime).apply()
        channel.invokeMethod(
                deferredDeepLinkUpdate,
                mapOf("deepLink" to deepLink, "timestamp" to cTime)
        )
      }
    }
    return isEmpty
  }
}
