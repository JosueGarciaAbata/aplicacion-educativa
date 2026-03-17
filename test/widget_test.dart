import 'package:aplicacion_educativa/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows login screen when there is no saved session', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp(initialUsername: null));

    expect(find.text('Iniciar sesion'), findsOneWidget);
    expect(find.text('Nombre de usuario'), findsOneWidget);
    expect(find.text('Ingresar'), findsOneWidget);
  });
}
