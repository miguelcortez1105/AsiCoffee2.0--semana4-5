// Teste de smoke atualizado para a v2.0: o app agora usa Riverpod, então
// precisa ser renderizado dentro de um ProviderScope.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:asicoffee/main.dart';

void main() {
  testWidgets('AsiCoffee smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: AsiCoffeeApp()),
    );

    // A aba inicial é "Cardápio Completo".
    expect(find.text('Cardápio Completo'), findsOneWidget);
    expect(find.text('Meus Favoritos'), findsNothing);
  });
}
