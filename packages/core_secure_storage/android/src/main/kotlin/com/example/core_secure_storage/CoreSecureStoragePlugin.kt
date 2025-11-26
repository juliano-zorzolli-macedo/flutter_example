package com.example.core_secure_storage

import android.content.Context
import androidx.annotation.NonNull
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.stringPreferencesKey
import androidx.datastore.preferences.preferencesDataStore
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import android.util.Base64
import kotlinx.coroutines.flow.catch
import packages.core_secure_storage.android.src.main.kotlin.com.example.core_secure_storage.CryptoManager

val Context.dataStore by preferencesDataStore(name = "secure_chat_prefs")

class CoreSecureStoragePlugin: FlutterPlugin, MethodCallHandler {
    private lateinit var channel : MethodChannel
    private lateinit var context: Context
    private val cryptoManager = CryptoManager()

    private val CHAT_LIST_KEY = stringPreferencesKey("encrypted_chat_list")

    private val scope = CoroutineScope(Dispatchers.IO)

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.example.flutter_example/secure_storage")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "saveChatList") {
            val data = call.argument<String>("data")
            if (data != null) {
                saveToDataStore(data, result)
            } else {
                result.error("INVALID_ARGS", "Data cannot be null", null)
            }
        } else if (call.method == "getChatList") {
            readFromDataStore(result)
        }
        else if (call.method == "getEncryptChatList") {
            readFromDecryptDataStore(result)
        } else {
            result.notImplemented()
        }
    }

    private fun saveToDataStore(plainText: String, result: Result) {
        scope.launch {
            try {
                val encryptedBytes = cryptoManager.encrypt(plainText.toByteArray(Charsets.UTF_8))
                val base64String = Base64.encodeToString(encryptedBytes, Base64.DEFAULT)
                context.dataStore.edit { preferences ->
                    preferences[CHAT_LIST_KEY] = base64String
                }
                withContext(Dispatchers.Main) {
                    result.success(null)
                }
            } catch (e: Exception) {
                withContext(Dispatchers.Main) {
                    result.error("SAVE_ERROR", e.message, null)
                }
            }
        }
    }

    private fun readFromDataStore(result: Result) {
        scope.launch {
            try {
                context.dataStore.data.catch { e ->
                    result.error("SAVE_ERROR", e.message, null)
                }.collect {
                    result.success(it[CHAT_LIST_KEY])
                }
            } catch (e: Exception) {
                result.error("SAVE_ERROR", e.message, null)
            }
        }
    }

    private fun readFromDecryptDataStore(result: Result) {
        scope.launch {
            try {
                context.dataStore.data.catch { e ->
                    result.error("SAVE_ERROR", e.message, null)
                }.collect {
                    val savedEncrypted = it[CHAT_LIST_KEY]
                    val savedBytes = Base64.decode(savedEncrypted, Base64.DEFAULT)
                    val decryptedBytes = cryptoManager.decrypt(savedBytes)
                    val decryptedString = String(decryptedBytes, Charsets.UTF_8)
                    result.success(decryptedString)
                }
            } catch (e: Exception) {
                result.error("SAVE_ERROR", e.message, null)
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
