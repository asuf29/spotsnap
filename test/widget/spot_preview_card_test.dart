import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapspot/shared/widgets/design_system/design_system.dart';

void main() {
  group('SpotPreviewCard', () {
    testWidgets('renders title', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SpotPreviewCard(
              title: 'Eiffel Tower',
              onTap: () {},
            ),
          ),
        ),
      );
      expect(find.text('Eiffel Tower'), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SpotPreviewCard(
              title: 'Test Spot',
              onTap: () => tapped = true,
            ),
          ),
        ),
      );
      await tester.tap(find.text('Test Spot'));
      expect(tapped, true);
    });

    testWidgets('shows shimmer when isLoading', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SpotPreviewCard(
              title: '',
              isLoading: true,
              onTap: () {},
            ),
          ),
        ),
      );
      expect(find.byType(ShimmerBox), findsOneWidget);
    });

    testWidgets('shows best time chip', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SpotPreviewCard(
              title: 'Test',
              bestTimeLabel: '18:00',
              onTap: () {},
            ),
          ),
        ),
      );
      expect(find.text('18:00'), findsOneWidget);
    });
  });
}
