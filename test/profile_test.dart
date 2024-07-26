import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kelompok9_toko_online/ui/pages/profile_page.dart';

void main() {
  testWidgets('Update Profile Success', (WidgetTester tester) async {
    await tester.pumpWidget(const ProfilePage());
    expect(find.textContaining('Profile & Password'), findsOneWidget);
  });
}
