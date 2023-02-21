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
// import 'package:game_queue/db/database.dart';

// import 'package:game_queue/main.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/hive_test.dart';
// import 'package:hive/src/hive_impl.dart';
// import 'package:path/path.dart' as path;


void main() {
  setUp(() async {
    await setUpTestHive();
  });
  //
  // String tempPath =
  // path.join(Directory.current.path, '.dart_tool', 'test', 'tmp');
  //
  // Future<Directory> getTempDir() async {
  //   var name = Random().nextInt(pow(2, 32) as int);
  //   var dir = Directory(path.join(tempPath, '${name}_tmp'));
  //   if (await dir.exists()) {
  //     await dir.delete(recursive: true);
  //   }
  //   await dir.create(recursive: true);
  //   return dir;
  // }
  //
  // Future<HiveImpl> initHive() async {
  //   var tempDir = await getTempDir();
  //   var hive = HiveImpl();
  //   hive.init(tempDir.path);
  //   return hive;
  // }

  // test('.init()', () {
  //   var hive = HiveImpl();
  //
  //   expect(() => hive.init('MYPATH'), returnsNormally);
  //   expect(hive.homePath, 'MYPATH');
  // });

  testWidgets('opened box is returned if it exists', (WidgetTester tester) async {
    // var hive = await initHive();
    // await hive.close();
    // tester.runAsync(() => Hive.openBox('playersBox'));
    // await tester.pumpWidget(const MyApp());
    //
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();
    //   var hive = HiveImpl();
    tester.runAsync(() => Hive.openBox('playersBox'));
    // final _playersBox = Hive.box('playersBox');
    // PalyersDataBase db = PalyersDataBase();
    // tester.runAsync(() => hive.openBox('playersBox'));
    // await tester.pumpWidget(const MyApp());

    // expect(box, true);

    await Hive.close();
  });

  // testWidgets('Adding palyer smoke test', (WidgetTester tester) async {
  //   // await Hive.initFlutter();
  //   var hive = await initHive();
  //   var box = await hive.openBox("playersBox");
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());
  //
  //   // // Verify that our counter starts at 0.
  //   // expect(find.text('0'), findsOneWidget);
  //   // expect(find.text('1'), findsNothing);
  //
  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();
  //
  //   // Verify that our counter has incremented.
  //   // expect(find.text('0'), findsNothing);
  //   // expect(find.text('1'), findsOneWidget);
  // });
}
