import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bottom_ani_nav_bar/bottom_ani_nav_bar.dart';

void main() {
  const MethodChannel channel = MethodChannel('bottom_ani_nav_bar');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  // test('getPlatformVersion', () async {
  //   expect(await BottomAniNavBar.platformVersion, '42');
  // });
}
