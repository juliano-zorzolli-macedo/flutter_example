import 'package:flutter/services.dart';

class CoreSecureStorage {
  static const MethodChannel _channel = MethodChannel('com.example.flutter_example/secure_storage');

  /// Salva uma string (ex: JSON) de forma encriptada no nativo
  Future<void> saveChatList(String jsonString) async {
    try {
      await _channel.invokeMethod('saveChatList', {'data': jsonString});
    } on PlatformException catch (e) {
      print("Erro ao salvar no nativo: ${e.message}");
      rethrow;
    }
  }

  /// Recupera a string descriptografada
  Future<String?> getChatList() async {
    try {
      final String? result = await _channel.invokeMethod('getChatList');
      return result;
    } on PlatformException catch (e) {
      print("Erro ao ler do nativo: ${e.message}");
      return null;
    }
  }

  /// Recupera a string criptografada
  Future<String?> getEncryptChatList() async {
    try {
      final String? result = await _channel.invokeMethod('getEncryptChatList');
      return result;
    } on PlatformException catch (e) {
      print("Erro ao ler do nativo: ${e.message}");
      return null;
    }
  }
}