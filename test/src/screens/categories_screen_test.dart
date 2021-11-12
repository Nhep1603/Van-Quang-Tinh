import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:van_quang_tinh/src/screens/categories_screen.dart';
import 'package:van_quang_tinh/src/widgets/categories_table.dart';

void main() {
  
  testWidgets('Display CategoriesTable', (WidgetTester tester) async{
    await tester.pumpWidget(const MaterialApp(home: CategoriesScreen(),));
    final categoriestableFinder = find.byType(CategoriesTable);
    expect(categoriestableFinder, findsOneWidget);
  }
  );

}