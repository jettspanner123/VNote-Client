import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vnote_client/shared/components/page/appbar_action_button.dart';

void main() {
  testWidgets('closes expanded content on outside tap', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Align(
            alignment: Alignment.topLeft,
            child: AppbarActionButton(
              expandHeight: 120,
              expandWidth: 180,
              expandInto: const Center(child: Text('Expanded content')),
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Expanded content'), findsNothing);

    await tester.tap(find.byType(AppbarActionButton));
    await tester.pumpAndSettle();

    expect(find.text('Expanded content'), findsOneWidget);

    await tester.tapAt(const Offset(350, 550));
    await tester.pumpAndSettle();

    expect(find.text('Expanded content'), findsNothing);
  });
}
