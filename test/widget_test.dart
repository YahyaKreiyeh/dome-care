import 'package:dome_care/core/routing/routes.dart';
import 'package:dome_care/dome_care.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DomeCare increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const DomeCare(initialRoute: Routes.login));
  });
}
