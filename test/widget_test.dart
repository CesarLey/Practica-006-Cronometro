// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:tiempoapp/core/app/timer_app.dart';

void main() {
  testWidgets('App shows Timer title', (WidgetTester tester) async {
    await tester.pumpWidget(const TimerApp());
    // single pump is enough to render AppBar/title; avoid pumpAndSettle which may time out
    await tester.pump();
    expect(find.text('Timer'), findsOneWidget);
  });
}
