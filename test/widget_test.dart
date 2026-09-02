import 'package:flutter_test/flutter_test.dart';
import 'package:salah_bell/main.dart';
import 'package:salah_bell/state/salah_store.dart';

void main() {
  testWidgets('shows Salah Bell', (tester) async {
    await tester.pumpWidget(SalahBellApp(store: SalahStore()));
    expect(find.text('Salah Bell'), findsOneWidget);
  });
}
