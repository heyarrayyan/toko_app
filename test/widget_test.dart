// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:toko_app/main.dart';
import 'package:toko_app/models/product.dart';
import 'package:toko_app/router/app_router.dart';
import 'package:toko_app/state/auth_state.dart';
import 'package:toko_app/state/cart_state.dart';

void main() {
  test('each product uses its assigned image asset', () async {
    expect(
      dummyProducts.map((product) => product.imageAsset).toList(),
      [
        'assets/products/sepatu-lari.png',
        'assets/products/tas-ransel.png',
        'assets/products/jam-tangan.png',
        'assets/products/headphone.png',
        'assets/products/botol-minum.png',
      ],
    );

    for (final product in dummyProducts) {
      await rootBundle.load(product.imageAsset);
    }
  });

  testWidgets('shows splash before login', (WidgetTester tester) async {
    final router = createRouter(AuthState(), CartState());
    await tester.pumpWidget(TokoApp(router: router));

    expect(find.text('Toko App'), findsOneWidget);
    expect(find.text('Login'), findsNothing);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('Login akun'), findsOneWidget);
  });
}
