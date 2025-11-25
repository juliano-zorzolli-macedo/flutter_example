import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'core_secure_storage_platform_interface.dart';

/// An implementation of [CoreSecureStoragePlatform] that uses method channels.
class MethodChannelCoreSecureStorage extends CoreSecureStoragePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('core_secure_storage');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
