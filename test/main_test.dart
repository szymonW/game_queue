// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'dart:io';
// import 'dart:math';
//
// import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:game_queue/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/hive_test.dart';


void main() {

  setUp(() async {
    await setUpTestHive();
  });

  testWidgets('opened box is returned if it exists', (tester) async {
    await tester.runAsync(() => Hive.openBox('playersBox'));
      await tester.pumpWidget(const HomePage()).whenComplete(() => Hive.openBox('playersBox'));
    await Hive.close();
  });
}
