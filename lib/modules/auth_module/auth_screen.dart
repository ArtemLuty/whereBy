import 'package:flutter/material.dart';
import 'package:whereby_app/modules/auth_module/views/auth_view.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: AuthView(),
        ),
      ),
    );
  }
}
