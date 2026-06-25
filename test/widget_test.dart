import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:snapspot/shared/widgets/app_logo.dart';

void main() {
  testWidgets('AppLogo renders brand name', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Center(child: AppLogo())),
      ),
    );

    expect(find.text('SnapSpot'), findsOneWidget);
  });
}
