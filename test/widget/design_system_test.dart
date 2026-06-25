import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapspot/features/spot/domain/entities/spot.dart';
import 'package:snapspot/shared/widgets/design_system/design_system.dart';
import 'package:snapspot/shared/widgets/empty_state.dart';

void main() {
  group('VibeChip', () {
    testWidgets('renders label text uppercased', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: VibeChip(label: 'Viral vibe')),
        ),
      );
      expect(find.text('VIRAL VIBE'), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VibeChip(
              label: 'Test',
              onTap: () => tapped = true,
            ),
          ),
        ),
      );
      await tester.tap(find.text('TEST'));
      expect(tapped, true);
    });
  });

  group('GoldenHourChip', () {
    testWidgets('renders label', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: GoldenHourChip(label: '18:42 – 19:30')),
        ),
      );
      expect(find.text('18:42 – 19:30'), findsOneWidget);
    });
  });

  group('GoldBadge', () {
    testWidgets('renders badge label', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: GoldBadge(label: 'Premium')),
        ),
      );
      expect(find.text('Premium'), findsOneWidget);
    });
  });

  group('CrowdIndicator', () {
    testWidgets('renders for each level', (tester) async {
      for (final level in CrowdLevel.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: CrowdIndicator(level: level)),
          ),
        );
        await tester.pumpAndSettle();
      }
    });
  });

  group('EmptyState', () {
    testWidgets('renders title, subtitle, icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EmptyState(
              icon: Icons.favorite_border,
              title: 'No favorites',
              subtitle: 'Tap heart to save spots.',
            ),
          ),
        ),
      );
      expect(find.text('No favorites'), findsOneWidget);
      expect(find.text('Tap heart to save spots.'), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    });

    testWidgets('renders action button when provided', (tester) async {
      var pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyState(
              icon: Icons.explore,
              title: 'Empty',
              subtitle: 'Nothing here',
              actionLabel: 'Discover',
              onAction: () => pressed = true,
            ),
          ),
        ),
      );
      expect(find.text('Discover'), findsOneWidget);
      await tester.tap(find.text('Discover'));
      expect(pressed, true);
    });

    testWidgets('hides action button when not provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EmptyState(
              icon: Icons.explore,
              title: 'Empty',
              subtitle: 'Nothing',
            ),
          ),
        ),
      );
      expect(find.byType(ElevatedButton), findsNothing);
    });
  });
}
