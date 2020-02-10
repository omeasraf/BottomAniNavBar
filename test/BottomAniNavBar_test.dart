import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:BottomAniNavBar/BottomAniNavBar.dart';

void main() {
  const MethodChannel channel = MethodChannel('BottomAniNavBar');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    print("I am ready");
  });
}
