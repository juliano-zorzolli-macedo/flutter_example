import 'package:flutter_test/flutter_test.dart';
import 'package:core_secure_storage/core_secure_storage.dart';
import 'package:core_secure_storage/core_secure_storage_platform_interface.dart';
import 'package:core_secure_storage/core_secure_storage_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCoreSecureStoragePlatform
    with MockPlatformInterfaceMixin
    implements CoreSecureStoragePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final CoreSecureStoragePlatform initialPlatform = CoreSecureStoragePlatform.instance;

  test('$MethodChannelCoreSecureStorage is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCoreSecureStorage>());
  });

  test('getPlatformVersion', () async {
    CoreSecureStorage coreSecureStoragePlugin = CoreSecureStorage();
    MockCoreSecureStoragePlatform fakePlatform = MockCoreSecureStoragePlatform();
    CoreSecureStoragePlatform.instance = fakePlatform;
  });
}
