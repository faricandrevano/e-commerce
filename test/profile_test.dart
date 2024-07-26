import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kelompok9_toko_online/bloc/user_bloc/user_bloc.dart';
import 'package:kelompok9_toko_online/services/user_service.dart';
import 'package:kelompok9_toko_online/ui/pages/profile_page.dart';

void main() {
  testWidgets('Update Profile Success', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserBloc(
              userService: UserService(),
            ),
          )
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: ProfilePage(),
          ),
        ),
      ),
    );
    expect(find.textContaining('Profile & Password'), findsOneWidget);
  });
}
